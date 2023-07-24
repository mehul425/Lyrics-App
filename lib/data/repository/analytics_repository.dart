import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:juna_bhajan/data/model/author.dart';
import 'package:juna_bhajan/data/model/bhajan.dart';
import 'package:juna_bhajan/data/model/singer.dart';
import 'package:juna_bhajan/data/model/youtube.dart';
import 'package:tuple/tuple.dart';

class AnalyticsRepository {
  final FirebaseAnalytics firebaseAnalytics;

  AnalyticsRepository({
    required this.firebaseAnalytics,
  });

  Future<void> setEnvironment(String type) {
    return firebaseAnalytics.setDefaultEventParameters({"environment": type});
  }

  Future<void> logAuthor(Author author) {
    return firebaseAnalytics.logEvent(name: "author", parameters: {
      "id": author.id,
      "name": author.name,
    });
  }

  Future<void> logBhajan(Bhajan bhajan) {
    return firebaseAnalytics.logEvent(name: "bhajan", parameters: {
      "id": bhajan.id,
      "name": bhajan.nameGuj,
      "eng_name": bhajan.nameEng,
    });
  }

  Future<void> logAddFavorite(Bhajan bhajan) {
    return firebaseAnalytics.logEvent(name: "favorite_add", parameters: {
      "id": bhajan.id,
      "name": bhajan.nameGuj,
      "eng_name": bhajan.nameEng,
    });
  }

  Future<void> logRemoveFavorite(Bhajan bhajan) {
    return firebaseAnalytics.logEvent(name: "favorite_remove", parameters: {
      "id": bhajan.id,
      "name": bhajan.nameGuj,
      "eng_name": bhajan.nameEng,
    });
  }

  Future<void> logYoutubeVideo(Tuple2<Bhajan, Youtube> tuple2) {
    return firebaseAnalytics.logEvent(name: "youtube", parameters: {
      "id": tuple2.item1.id,
      "youtube_id": tuple2.item2.id,
      "name": tuple2.item1.nameGuj,
      "eng_name": tuple2.item1.nameEng,
      "youtube_name": tuple2.item2.name,
    });
  }

  Future<void> logSinger(Singer singer) {
    return firebaseAnalytics.logEvent(name: "singer", parameters: {
      "id": singer.id,
      "name": singer.name,
    });
  }

  Future<void> logFilter(String filterBy, String id, String name) {
    return firebaseAnalytics.logEvent(name: "filter", parameters: {
      "filterBy": filterBy,
      "id": id,
      "name": name,
    });
  }

  Future<void> logSearch(String query) {
    return firebaseAnalytics.logEvent(name: "search", parameters: {
      "query": query,
    });
  }

  Future<void> logLogin() {
    return firebaseAnalytics.logLogin(loginMethod: "google");
  }

  Future<void> logLogout() {
    return firebaseAnalytics.logEvent(name: "logout");
  }

  Future<void> logFontSetting(
    String fontFamily,
    double fontSize,
    double fontBrightness,
    int fontWeight,
  ) {
    return firebaseAnalytics.logEvent(name: "font-setting", parameters: {
      "fontFamily": fontFamily,
      "fontSize": fontSize,
      "fontBrightness": fontBrightness / 10,
      "fontWeight": fontWeight + 1,
    });
  }

  Future<void> logShareClick() {
    return firebaseAnalytics.logEvent(name: "share_click");
  }

  Future<void> logRateUsClick() {
    return firebaseAnalytics.logEvent(name: "rate_us_click");
  }

  Future<void> logOtherAppClick() {
    return firebaseAnalytics.logEvent(name: "other_app_click");
  }

  Future<void> logOptionalAppUpdate() {
    return firebaseAnalytics.logEvent(name: "option_app_update");
  }

  Future<void> logForceAppUpdate() {
    return firebaseAnalytics.logEvent(name: "force_app_update");
  }

  Future<void> logContactUsClick() {
    return firebaseAnalytics
        .logEvent(name: "contact_us_click", parameters: {"by": "telegram"});
  }

  Future<void> logRateUsDialogShow() {
    return firebaseAnalytics.logEvent(name: "rate_us_dialog_show");
  }

  Future<void> logRateUsRated() {
    return firebaseAnalytics.logEvent(name: "rate_us_rated");
  }

  Future<void> logRateUsLater() {
    return firebaseAnalytics.logEvent(name: "rate_us_later");
  }
}
