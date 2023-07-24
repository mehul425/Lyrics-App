import 'package:equatable/equatable.dart';
import 'package:juna_bhajan/data/model/list_data.dart';

class Update extends Equatable {
  final int minAppVersion;
  final int latestAppVersion;
  final bool isShowAds;
  final bool isRetryAds;
  final List<int> retryIntervals;

  const Update({
    required this.minAppVersion,
    required this.latestAppVersion,
    required this.isShowAds,
    required this.isRetryAds,
    required this.retryIntervals,
  });

  factory Update.fromListData(ListData listData) {
    return Update(
      minAppVersion: listData.data!["min_app_version"],
      latestAppVersion: listData.data!["latest_app_version"],
      isShowAds: listData.data!["is_show_ads"] ?? true,
      isRetryAds: listData.data!["is_retry_ads"] ?? false,
      retryIntervals: listData.data!["retry_intervals"] != null
          ? (listData.data!["retry_intervals"] as List<dynamic>).cast<int>()
          : <int>[],
    );
  }

  factory Update.fromJson(Map<dynamic, dynamic> json) {
    return Update(
      minAppVersion: json["min_app_version"],
      latestAppVersion: json["latest_app_version"],
      isShowAds: json["is_show_ads"],
      isRetryAds: json["is_retry_ads"],
      retryIntervals: (json["retry_intervals"] as List<dynamic>).cast<int>(),
    );
  }

  Update copyWith({
    int? minAppVersion,
    int? latestAppVersion,
    bool? isShowAds,
    bool? isRetryAds,
    List<int>? retryIntervals,
  }) {
    return Update(
      minAppVersion: minAppVersion ?? this.minAppVersion,
      latestAppVersion: latestAppVersion ?? this.latestAppVersion,
      isShowAds: isShowAds ?? this.isShowAds,
      isRetryAds: isRetryAds ?? this.isRetryAds,
      retryIntervals: retryIntervals ?? this.retryIntervals,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "min_app_version": minAppVersion,
      "latest_app_version": latestAppVersion,
      "is_show_ads": isShowAds,
      "is_retry_ads": isRetryAds,
      "retry_intervals": retryIntervals,
    };
  }

  Map<String, dynamic> toLocalJson() {
    return <String, dynamic>{
      "min_app_version": minAppVersion,
      "latest_app_version": latestAppVersion,
      "is_show_ads": isShowAds,
      "is_retry_ads": isRetryAds,
      "retry_intervals": retryIntervals,
    };
  }

  @override
  List<Object?> get props => [
        minAppVersion,
        latestAppVersion,
        isShowAds,
        isRetryAds,
        retryIntervals,
      ];
}
