import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/app_theme.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/core/router.dart';
import 'package:juna_bhajan/data/repository/analytics_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/data/repository/auth_repository.dart';
import 'package:juna_bhajan/data/repository/home_repository.dart';
import 'package:juna_bhajan/data/repository/local_repository.dart';
import 'package:juna_bhajan/data/sharedpref/shared_preference_helper.dart';
import 'package:juna_bhajan/utility/crash_reporting_tree.dart';
import 'package:juna_bhajan/view/setting/setting_bloc.dart';
import 'package:juna_bhajan/view/setting/setting_event.dart';
import 'package:juna_bhajan/view/setting/setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // await setupFlutterNotifications();
  // showFlutterNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  if (kDebugMode) {
    Fimber.plantTree(DebugTree(useColors: true));
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    await firebaseAnalytics.setAnalyticsCollectionEnabled(false);
    await FirebasePerformance.instance.setPerformanceCollectionEnabled(false);
  } else {
    Fimber.plantTree(CrashReportingTree());
  }

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  SharedPreferencesHelper sharedPreferencesHelper =
      SharedPreferencesHelper(sharedPreferences);

  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  firebaseDatabase.setPersistenceEnabled(true);
  if (kDebugMode) {
    firebaseDatabase.setLoggingEnabled(false);
  }

  AnalyticsRepository analyticsRepository =
      AnalyticsRepository(firebaseAnalytics: firebaseAnalytics);

  LocalRepository localRepository =
      LocalRepository(preferencesHelper: sharedPreferencesHelper);

  ApiRepository apiRepository = ApiRepository(
    firebaseDatabase: firebaseDatabase,
    preferencesHelper: sharedPreferencesHelper,
  );

  HomeRepository homeRepository = HomeRepository(
    apiRepository: apiRepository,
    localRepository: localRepository,
  );

  AuthRepository authRepository =
      AuthRepository(localRepository: localRepository);

  if (kDebugMode) {
    analyticsRepository.setEnvironment("DEV");
  } else {
    analyticsRepository.setEnvironment("PROD");
  }
  final appRouter = AppRouter();

  // Errors outside of Flutter
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: const [Locale('gu', '')],
    child: MyApp(
      preferenceHelper: sharedPreferencesHelper,
      firebaseAnalytics: firebaseAnalytics,
      apiRepository: apiRepository,
      localRepository: localRepository,
      authRepository: authRepository,
      homeRepository: homeRepository,
      appRouter: appRouter,
      analyticsRepository: analyticsRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferencesHelper preferenceHelper;
  final FirebaseAnalytics firebaseAnalytics;
  final AnalyticsRepository analyticsRepository;
  final ApiRepository apiRepository;
  final AuthRepository authRepository;
  final LocalRepository localRepository;
  final HomeRepository homeRepository;
  final AppRouter appRouter;

  const MyApp({
    required this.preferenceHelper,
    required this.firebaseAnalytics,
    required this.apiRepository,
    required this.authRepository,
    required this.localRepository,
    required this.homeRepository,
    required this.analyticsRepository,
    required this.appRouter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: preferenceHelper),
        RepositoryProvider.value(value: analyticsRepository),
        RepositoryProvider.value(value: apiRepository),
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: localRepository),
        RepositoryProvider.value(value: homeRepository),
        RepositoryProvider.value(value: ProjectType.junaBhajan),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) => SettingBloc(
          preferencesHelper: preferenceHelper,
          analyticsRepository: context.read<AnalyticsRepository>(),
          apiRepository: context.read<ApiRepository>(),
          authRepository: context.read<AuthRepository>(),
          projectType: context.read<ProjectType>(),
        )..add(const LoadInitialSettingDataEvent()),
        child: BlocBuilder<SettingBloc, SettingState>(
            buildWhen: (previous, current) =>
                previous.themeMode != current.themeMode,
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                title: 'જુના ભજન',
                theme: ThemeController.lightTheme(
                    projectType: ProjectType.junaBhajan),
                darkTheme: ThemeController.darkTheme(
                    projectType: ProjectType.junaBhajan),
                themeMode: state.themeMode,
                routerDelegate: appRouter.delegate(
                  navigatorObservers: () => [
                    FirebaseAnalyticsObserver(
                      analytics: firebaseAnalytics,
                      nameExtractor: (settings) {
                        switch (settings.name) {
                          case DashboardRouter.name:
                            return "/dashboard";
                          case HomeRouter.name:
                            return "/";
                          case BhajanRouter.name:
                            return "/bhajan";
                          case BhajanListRouter.name:
                            return "/bhajan-list";
                          case AuthorRouter.name:
                            return "/author";
                          case AuthorListRouter.name:
                            return "/author-list";
                          case SingerRouter.name:
                            return "/singer";
                          case SingerListRouter.name:
                            return "/singer-list";
                          case YoutubeListRouter.name:
                            return "/youtube-list";
                          case RelatedListRouter.name:
                            return "/related-list";
                          case FavoriteRouter.name:
                            return "/favorite-list";
                          case AboutUsRouter.name:
                            return "/aboutUs";
                          case SettingRouter.name:
                            return "/setting";
                          case FontSettingRouter.name:
                            return "/fontSetting";
                          default:
                            return settings.name;
                        }
                      },
                    )
                  ],
                ),
                routeInformationParser: appRouter.defaultRouteParser(),
              );
            }),
      ),
    );
  }
}
