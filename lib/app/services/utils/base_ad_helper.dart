// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// // import 'package:google_mobile_ads/google_mobile_ads.dart';
// // import 'package:zenzephyr/ui/dashboard_screen/controller/dashboard_controller.dart';
// // import 'package:zenzephyr/utils/storage_keys.dart';

// class BaseAdHelper {
//   InterstitialAd? _interstitialAd;
//   int _numInterstitialLoadAttempts = 0;

//   int maxFailedLoadAttempts = 3;
//   bool isAdOnScreen = false;

//   static const AdRequest request = AdRequest(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     nonPersonalizedAds: true,
//   );

//   // create a banner ad

//   void _createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/1033173712' //test key android
//             : 'ca-app-pub-3940256099942544/4411468910', //test key ios
//         // ? 'ca-app-pub-4750468680570727/5117726897' //live key android
//         // : 'ca-app-pub-4750468680570727/1094737316', // live key ios
//         request: request,
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             if (kDebugMode) {
//               print('$ad loaded');
//             }
//             _interstitialAd = ad;
//             _numInterstitialLoadAttempts = 0;
//             _interstitialAd!.setImmersiveMode(true);
//             _showInterstitialAd();
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             if (kDebugMode) {
//               print('InterstitialAd failed to load: $error.');
//             }
//             _numInterstitialLoadAttempts += 1;
//             _interstitialAd = null;
//             if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
//               _createInterstitialAd();
//             }
//           },
//         ));
//   }

//   void _showInterstitialAd() {
//     if (_interstitialAd == null) {
//       if (kDebugMode) {
//         print('Warning: attempt to show interstitial before loaded.');
//       }
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) {
//         if (kDebugMode) {
//           print('print $ad onAdShowedFullScreenContent.');
//         }
//         isAdOnScreen = true;
//       },
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         if (kDebugMode) {
//           print('print $ad onAdDismissedFullScreenContent.');
//         }
//         ad.dispose();
//         log("Ads Closed ---------->>>>>>>>>>>>>>>>");
//         isAdOnScreen = false;
//         // Get.to(() => const SubscriptionScreen());
//         // _createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         if (kDebugMode) {
//           print('print $ad onAdFailedToShowFullScreenContent: $error');
//         }
//         isAdOnScreen = false;
//         ad.dispose();
//         _createInterstitialAd();
//       },
//     );
//     if (isAdOnScreen == false) {
//       log("Shown Ad");
//       _interstitialAd!.show();
//     }

//     _interstitialAd = null;
//   }

//   // dispose the ad
//   void adDispose() {
//     _interstitialAd?.dispose();
//   }

//   void showAd() async {
//     DashboardController dashboardController = Get.find<DashboardController>();
//     if (dashboardController.subscriptionType.value == StorageKeys.basicSub) {
//       _createInterstitialAd();
//     }
//   }
// }
