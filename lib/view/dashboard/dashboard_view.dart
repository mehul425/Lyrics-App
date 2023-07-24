import 'package:auto_route/auto_route.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juna_bhajan/core/constant.dart';
import 'package:juna_bhajan/data/model/result_state.dart';
import 'package:juna_bhajan/data/repository/ads_repository.dart';
import 'package:juna_bhajan/data/repository/api_repository.dart';
import 'package:juna_bhajan/data/repository/home_repository.dart';
import 'package:juna_bhajan/data/repository/local_repository.dart';
import 'package:juna_bhajan/data/service/notification_service.dart';
import 'package:juna_bhajan/view/ads/ads_retry_policy.dart';
import 'package:juna_bhajan/view/ads/anchored_retry_ads_view.dart';
import 'package:juna_bhajan/view/home/home_bloc.dart';
import 'package:juna_bhajan/view/home/home_event.dart';
import 'package:juna_bhajan/view/home/home_state.dart';

@RoutePage(name: 'DashboardRouter')
class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      FirebaseMessaging.instance.getToken().then((value) {
        Fimber.d(value.toString());
      });
    }

    setupFlutterNotifications();

    if (kDebugMode) {
      FirebaseMessaging.instance.subscribeToTopic('test');
    } else {
      FirebaseMessaging.instance.subscribeToTopic('all');
    }

    FirebaseMessaging.onMessage.listen(
      (event) {
        showFlutterNotification(event);
      },
    );
    setupInteractedMessage();
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    // if (message.data.isNotEmpty && int.parse(message.data["course_id"]) != 0) {
    // context.pushRoute(CourseDetailsRouter(
    //   courseId: int.parse(message.data["course_id"]),
    //   courseTitle: message.data["course_title"],
    // ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        create: (context) => HomeBloc(
          apiRepository: context.read<ApiRepository>(),
          localRepository: context.read<LocalRepository>(),
          homeRepository: context.read<HomeRepository>(),
        )..add(const LoadHomeDataEvent()),
        child: Column(
          children: [
            const Expanded(child: AutoRouter()),
            BlocBuilder<HomeBloc, ResultState<HomeState>>(
              builder: (context, result) {
                return result.maybeWhen(
                  orElse: () => const SizedBox(),
                  success: (data) => AnchoredRetryAdsView(
                    adUnitId: AdsRepository.getBannerAdUnitId(
                      projectType: context.read<ProjectType>(),
                    ),
                    adsRetryPolicy: AdsRetryPolicy(
                      isShowAds: data.update.isShowAds,
                      isRetryAds: data.update.isRetryAds,
                      retryIntervals: data.update.retryIntervals
                          .map((e) => Duration(milliseconds: e))
                          .toList(),
                    ),
                  ),
                  // success: (data) => AnchoredAdaptiveView(
                  //   projectType: context.read<ProjectType>(),
                  // ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
