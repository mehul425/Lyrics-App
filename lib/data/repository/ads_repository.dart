import 'package:flutter/foundation.dart';
import 'package:juna_bhajan/core/constant.dart';

class AdsRepository {
  static String getBannerAdUnitId({required ProjectType projectType}) {
    switch (projectType) {
      case ProjectType.junaBhajan:
        if (kDebugMode) {
          return 'ca-app-pub-3940256099942544/6300978111';
        } else {
          return 'your-admob-account-banner-id';
        }
      case ProjectType.hindBhajan:
        if (kDebugMode) {
          return 'ca-app-pub-3940256099942544/6300978111';
        } else {
          return 'your-admob-account-banner-id';
        }
    }
  }
}
