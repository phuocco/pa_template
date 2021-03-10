import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/utils/ad_manager.dart';

class AdsController extends GetxController {
  String a = "test";

  final count = 0.obs;


  AdRequest adRequest = AdRequest(testDevices: [
    'C53C9F562E282082EAFCDB42BF360BC1',
    '79A2C46F7F42017B2CD92F43970F4F2F',
    'e645b85f78980a92381fe225e3df5aec'
  ]);

  BannerAd myBanner;
  loadBanner() => myBanner.load();

  NativeAd myNativeAd;
  loadNative() {
    print('cac');
    myNativeAd.load();
  }

  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;

  showIntersAds() {
    if (!_interstitialReady) return;
    _interstitialAd.show();
    _interstitialReady = false;
    _interstitialAd = null;
  }

  void createInterstitialAd() {
    _interstitialAd ??= InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      request: adRequest,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          _interstitialReady = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          _interstitialAd = null;
          createInterstitialAd();
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed.');
          ad.dispose();
          createInterstitialAd();
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    )..load();
  }

  RewardedAd _rewardedAd;
  bool _rewardedReady = false;

  showRewardedAd(){
    if (!_rewardedReady) return;
    _rewardedAd.show();
    _rewardedReady = false;
    _rewardedAd = null;
  }

  void createRewardedAd() {
    _rewardedAd ??= RewardedAd(
      adUnitId: "ca-app-pub-3940256099942544/5224354917",
      request: adRequest,
      listener: AdListener(
          onAdLoaded: (Ad ad) {
            print('${ad.runtimeType} loaded.');
            _rewardedReady = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('${ad.runtimeType} failed to load: $error');
            ad.dispose();
            _rewardedAd = null;
            createRewardedAd();
          },
          onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
          onAdClosed: (Ad ad) {
            print('${ad.runtimeType} closed.');
            ad.dispose();
            createRewardedAd();
          },
          onApplicationExit: (Ad ad) =>
              print('${ad.runtimeType} onApplicationExit.'),
          onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
            print(
              '$RewardedAd with reward $RewardItem(${reward.amount}, ${reward.type})',
            );
            count.value ++;
          }),
    )..load();
  }

  @override
  void onInit() {
    initAds();
    MobileAds.instance.initialize().then((InitializationStatus status) {
      print('Init ads done: ${status.adapterStatuses}');
      MobileAds.instance
          .updateRequestConfiguration(RequestConfiguration(
              tagForChildDirectedTreatment:
                  TagForChildDirectedTreatment.unspecified))
          .then((value) {
        createInterstitialAd();
        createRewardedAd();
      });
    });
    super.onInit();
  }

  @override
  void onClose() {
    myBanner?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    // myNativeAd?.dispose();
    // myNativeAd=null;
    super.onClose();
  }

  @override
  void onReady() {}

  initAds() {
    myBanner = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.getSmartBanner(Orientation.portrait),
      request: adRequest,
      listener: AdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('bannerAd loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an ad is in the process of leaving the application.
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    );
    myNativeAd = NativeAd(
      adUnitId: AdManager.nativeAdUnitId,
      factoryId: 'adFactoryExample',
      request: adRequest,
      listener: AdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('Native Ad loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an ad is in the process of leaving the application.
        onApplicationExit: (Ad ad) => print('Left application.'),
        // Called when a click is recorded for a NativeAd.
        onNativeAdClicked: (NativeAd ad) => print('Ad clicked.'),
        // Called when an impression is recorded for a NativeAd.
        onNativeAdImpression: (NativeAd ad) => print('Ad impression.'),
      ),
    );

    loadBanner();
    loadNative();
  }
}
