import 'dart:async';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/data/model/exception.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/data/repository/auth_repository.dart';
import 'package:juna_bhajan/data/sharedpref/preferences.dart';
import 'package:juna_bhajan/data/sharedpref/shared_preference_helper.dart';
import 'package:juna_bhajan/view/setting/setting_event.dart';
import 'package:juna_bhajan/view/setting/setting_state.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SharedPreferencesHelper preferencesHelper;
  final AnalyticsRepository analyticsRepository;
  final ApiRepository apiRepository;
  final AuthRepository authRepository;
  final ProjectType projectType;
  late StreamSubscription authStatesSubscription;

  SettingBloc({
    required this.preferencesHelper,
    required this.analyticsRepository,
    required this.apiRepository,
    required this.authRepository,
    required this.projectType,
  }) : super(SettingState.initial()) {
    on<LoadInitialSettingDataEvent>((event, emit) async {
      emit(state.copyWith(
        themeMode: ThemeMode
            .values[preferencesHelper.getInt(Preferences.theme, defValue: 1)],
        fontSize:
            preferencesHelper.getDouble(Preferences.fontSize, defValue: 18),
        fontFamily: preferencesHelper.getString(
          Preferences.fontFamily,
          defValue: projectType == ProjectType.junaBhajan
              ? gujaratiDefaultFontFamily
              : hindiDefaultFontFamily,
        ),
        fontBrightness: preferencesHelper.getDouble(Preferences.fontBrightness,
            defValue: 10),
        fontWeight:
            preferencesHelper.getInt(Preferences.fontWeight, defValue: 8),
      ));

      await PackageInfo.fromPlatform().then((packageInfo) {
        emit(state.copyWith(
          appVersionName: packageInfo.version,
          currentAppVersion: int.parse(packageInfo.buildNumber),
        ));
      }, onError: (e, str) {
        FimberLog("SettingBloc")
            .e("Loading App Update", ex: e, stacktrace: str);
      });
    });

    on<GoogleAuthChangeSettingDataEvent>((event, emit) {
      emit(state.copyUser(user: event.user));
    });

    on<GoogleLoginOutSettingDataEvent>((event, emit) async {
      analyticsRepository.logLogout();
      await authRepository.signOut();
    });

    on<GoogleLoginSettingDataEvent>((event, emit) async {
      bool result = await InternetConnectionChecker().hasConnection;
      emit(state.copyWith(isLoading: true, error: ""));
      if (result) {
        await authRepository.login().then((value) async {
          await apiRepository.addUser(value).first;
          analyticsRepository.logLogin();
          emit(state.copyWith(isLoading: false));
        }).catchError((e, str) {
          if (e is NetworkException) {
            emit(state.copyWith(isLoading: false, error: e.message));
            if (e.message != "It seems you've canceled login") {
              FimberLog("SettingBloc")
                  .e("Login with Google", ex: e, stacktrace: str);
            }
          } else {
            emit(state.copyWith(
                isLoading: false, error: "Something wrong try again."));
            FimberLog("SettingBloc")
                .e("Login with Google", ex: e, stacktrace: str);
          }
        });
      } else {
        emit(
            state.copyWith(isLoading: false, error: "No Internet Connection."));
      }
    });

    on<ChangeThemeDataEvent>((event, emit) async {
      emit(state.copyWith(
        themeMode: event.themeMode,
      ));
      await preferencesHelper.putInt(Preferences.theme, event.themeMode.index);
    });

    on<ChangeFontSizeEvent>((event, emit) async {
      emit(state.copyWith(
        fontSize: event.fontSize,
      ));
    });

    on<ChangeFontFamilyEvent>((event, emit) async {
      emit(state.copyWith(
        fontFamily: event.fontFamily,
      ));
    });

    on<ChangeFontBrightnessEvent>((event, emit) async {
      emit(state.copyWith(
        fontBrightness: event.fontBrightness,
      ));
    });

    on<ChangeFontWeightEvent>((event, emit) async {
      emit(state.copyWith(
        fontWeight: event.fontWeight.toInt(),
      ));
    });

    on<SaveFontSettingDataEvent>((event, emit) async {
      await preferencesHelper.putDouble(Preferences.fontSize, state.fontSize);
      await preferencesHelper.putString(
          Preferences.fontFamily, state.fontFamily);
      await preferencesHelper.putDouble(
          Preferences.fontBrightness, state.fontBrightness);
      await preferencesHelper.putInt(Preferences.fontWeight, state.fontWeight);
      analyticsRepository.logFontSetting(state.fontFamily, state.fontSize,
          state.fontBrightness, state.fontWeight);
    });

    authStatesSubscription = authRepository.status.listen((event) {
      add(GoogleAuthChangeSettingDataEvent(user: event));
    });
  }

  @override
  Future<void> close() {
    authStatesSubscription.cancel();
    authRepository.dispose();
    return super.close();
  }
}
