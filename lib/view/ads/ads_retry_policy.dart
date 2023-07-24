class AdsRetryPolicy {
  const AdsRetryPolicy({
    required this.isShowAds,
    required this.isRetryAds,
    required this.retryIntervals,
  });

  final bool isShowAds;
  final bool isRetryAds;

  /// The interval between retries to load an ad.
  final List<Duration> retryIntervals;

  /// The maximum number of retries to load an ad.
  int get maxRetryCount => retryIntervals.length;

  /// Returns the interval for the given retry.
  Duration getIntervalForRetry(int retry) {
    if (retry <= 0 || retry > maxRetryCount) return Duration.zero;
    return retryIntervals[retry - 1];
  }
}
