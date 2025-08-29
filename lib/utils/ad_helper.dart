import 'package:flutter/foundation.dart';

class AdHelper {
  /// Interstitial ad
  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Test interstitial
    } else {
      return 'ca-app-pub-1581073586389436/6751914409'; // Tekko Interstitial
    }
  }

  /// Banner ad
  static String get bannerAdUnitId {
    if (kDebugMode) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Test banner
    } else {
      return 'ca-app-pub-1581073586389436/6100375388'; // Tekko Banner
    }
  }

  // static String get rewardedAdUnitId { ... }
  // static String get nativeAdUnitId { ... }
}
