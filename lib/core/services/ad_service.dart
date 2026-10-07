import 'dart:async';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract final class AdService {
  static String get rewardedTestId => Platform.isAndroid ? 'ca-app-pub-3940256099942544/5224354917' : 'ca-app-pub-3940256099942544/1712485313';
  static String get interstitialTestId => Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/4411468910';
  static String get bannerTestId => Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716';

  static Future<bool> showStartRewarded() async {
    final completer = Completer<bool>();
    RewardedAd.load(
      adUnitId: rewardedTestId, request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdFailedToLoad: (_) => completer.complete(false),
        onAdLoaded: (ad) {
          var earned = false;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) { ad.dispose(); if (!completer.isCompleted) completer.complete(earned); },
            onAdFailedToShowFullScreenContent: (ad, _) { ad.dispose(); if (!completer.isCompleted) completer.complete(false); },
          );
          ad.show(onUserEarnedReward: (_, __) => earned = true);
        },
      ),
    );
    return completer.future;
  }

  static Future<void> showResultInterstitial() async {
    final completer = Completer<void>();
    InterstitialAd.load(
      adUnitId: interstitialTestId, request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdFailedToLoad: (_) => completer.complete(),
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) { ad.dispose(); if (!completer.isCompleted) completer.complete(); },
            onAdFailedToShowFullScreenContent: (ad, _) { ad.dispose(); if (!completer.isCompleted) completer.complete(); },
          );
          ad.show();
        },
      ),
    );
    return completer.future;
  }
}
