import 'package:flutter/foundation.dart';

class AdHelper {
  static String get interstitialAdUnitId {
    if (kDebugMode) {
      // Test ID oficial de Google
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      // Tu ID real en producción
      return 'ca-app-pub-1581073586389436/6751914409';
    }
  }
}
