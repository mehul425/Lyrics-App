import 'package:collection/collection.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/data/repository/home_repository.dart';
import 'package:juna_bhajan/data/repository/local_repository.dart';
import 'package:juna_bhajan/extension/other_extension.dart';
import 'package:juna_bhajan/view/home/home_event.dart';
import 'package:juna_bhajan/view/home/home_state.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tuple/tuple.dart';

class HomeBloc extends Bloc<HomeEvent, ResultState<HomeState>> {
  final ApiRepository apiRepository;
  final LocalRepository localRepository;
  final HomeRepository homeRepository;

  HomeBloc({
    required this.apiRepository,
    required this.localRepository,
    required this.homeRepository,
  }) : super(const ResultState.loading()) {
    on<LoadHomeDataEvent>((event, emit) async {
      emit(const ResultState.loading());
      bool result = await InternetConnectionChecker().hasConnection;
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (result) {
        await homeRepository.getHomeDetails().then((value) {
          emit(ResultState.success(
            data: HomeState(
              bhajanList: value.bhajanList,
              authorList: value.authorList,
              singerList: value.singleList.take(10).toList(),
              topAuthorList: value.topAuthorList
                  .map((e) => value.authorList
                      .firstWhereOrNull((element) => element.id == e))
                  .whereNotNull()
                  .toList(),
              newAddedBhajanList: value.newAddBhajanList
                  .map((e) => value.bhajanList
                      .firstWhereOrNull((element) => element.id == e))
                  .whereNotNull()
                  .toList(),
              ourFavoriteBhajanList: value.ourFavoriteBhajanList
                  .map((e) => value.bhajanList
                      .firstWhereOrNull((element) => element.id == e))
                  .whereNotNull()
                  .toList(),
              topYoutubeBhajanList: value.topYoutubeBhajanList
                  .map((e) => value.youtubeList
                      .firstWhereOrNull((element) => element.id == e))
                  .whereNotNull()
                  .map((e) => Tuple2(
                      value.bhajanList.firstWhereOrNull(
                          (element) => element.id == e.bhajanId),
                      e))
                  .where((element) => element.item1 != null)
                  .map((e) => Tuple2(e.item1!, e.item2))
                  .toList(),
              typeList: value.typeList,
              tagList: value.tagList,
              relatedList: value.relatedList,
              canShowRatingDialog: false,
              currentAppVersion: int.parse(packageInfo.buildNumber),
              update: value.update,
            ),
          ));
          add(const CheckRatingStatusEvent());
        }, onError: (e, str) {
          emit(ResultState.failure(object: e));
          FimberLog("HomeBloc").e("Loading Home", ex: e, stacktrace: str);
        });
      } else {
        emit(const ResultState.noInternet());
      }
    });

    on<CheckRatingStatusEvent>((event, emit) async {
      await localRepository.increaseAppOpenCount();
      if (localRepository.getFirstTime()) {
        await localRepository.saveIsFirstTime();
        await localRepository.setFirstTimeDate();
      } else if (!localRepository.isRemindOrRated()) {
        DateTime dateTime = localRepository.getFirstTimeDate();
        if (DateTime.now()
                    .getDateOnly()
                    .difference(dateTime.getDateOnly())
                    .inDays >
                1 &&
            localRepository.getAppOpenCount() > 2) {
          state.whenOrNull(
            success: (data) {
              emit(ResultState.success(
                  data: data.copyWith(canShowRatingDialog: true)));
            },
          );
        }
      }
    });

    on<RatedStatusEvent>((event, emit) async {
      state.whenOrNull(
        success: (data) {
          emit(ResultState.success(
              data: data.copyWith(canShowRatingDialog: false)));
        },
      );
      await localRepository.rated();
    });

    on<RemindMeLaterStatusEvent>((event, emit) async {
      state.whenOrNull(
        success: (data) {
          emit(ResultState.success(
              data: data.copyWith(canShowRatingDialog: false)));
        },
      );
      await localRepository.remindMeLater();
    });
  }
}
