import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_inapp_purchase/modules.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/utils/ad_manager.dart';

class AdsController extends GetxController {

  final isPremium = false.obs;
  static bool initPurchase = false;
  final box = GetStorage();

  //region purchase
  StreamSubscription purchaseUpdatedSubscription;
  StreamSubscription purchaseErrorSubscription;
  final List<String> _productLists = GetPlatform.isAndroid
      ? [
    'premium',
  ]
      : ['premium_yugioh'];
  final _platformVersion = 'Unknown'.obs;
  final _items = <IAPItem>[].obs;
  final _purchases = <PurchasedItem>[].obs;

  get items => _items;
  get purchases => _purchases;

  bool getPremium()  {
    bool check  = box.read('IS_PREMIUM');
    update();
     return check;
  }


  //endregion

  //region ads
  String a = "test";

  final count = 0.obs;

  AdRequest adRequest = AdRequest(testDevices: [
    'C53C9F562E282082EAFCDB42BF360BC1',
    '79A2C46F7F42017B2CD92F43970F4F2F',
    'e645b85f78980a92381fe225e3df5aec',
    '5D0652DC72425F6CECA87D81F7962752'
  ]);

  BannerAd myBanner;
  final bannerCompleter = Completer<BannerAd>().obs;
  loadBanner() => myBanner.load();

  NativeAd myNativeAd;
  final nativeAdCompleter = Completer<NativeAd>().obs;
  loadNative() => myNativeAd.load();


  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;

  RewardedAd _rewardedAd;
  bool _rewardedReady = false;

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

  //endregion
  @override
  void onInit() {

    initPlatformState();

    if(box.read('IS_PREMIUM') == true){
      isPremium.value = true;
      return;
    }
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
    myBanner = null;
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    myNativeAd?.dispose();
    myNativeAd=null;
    purchaseUpdatedSubscription.cancel();
    purchaseErrorSubscription.cancel();
    super.onClose();
  }

  @override
  void onReady() {

  }

  purchased(){
    if(isPremium.value == false){
      isPremium.value = true;
      print('purchased');
      box.write('IS_PREMIUM', isPremium.value);
    }
  }

  initAds() {
    myBanner = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.getSmartBanner(Orientation.portrait),
      request: adRequest,
      listener: AdListener(
        onAdLoaded: (Ad ad) { print('bannerAd loaded.');
        bannerCompleter.value.complete(ad as BannerAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to load: $error');
          bannerCompleter.value.completeError(null);
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    );
    myNativeAd = NativeAd(
      adUnitId: AdManager.nativeAdUnitId,
      request: adRequest,
      factoryId: 'adFactoryExample',
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded..');
          nativeAdCompleter.value.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          nativeAdCompleter.value.completeError(null);
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$NativeAd onApplicationExit.'),
      ),
    );
    Future<void>.delayed(Duration(seconds: 1), () => myNativeAd?.load());

    loadBanner();
    loadNative();
  }



  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    await FlutterInappPurchase.instance.initConnection;


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.


    _platformVersion.value = platformVersion;


    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      print('purchase-updated: $productItem');
    });

    purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });

    await getProduct();
    await getPurchaseHistory();
    initPurchase =  true;
  }

  void requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('get items');
      print('${item.toString()}');
      this._items.add(item);
    }
    print('get products');
      _items.assignAll(items);
      _purchases.assignAll([]);
  }

  Future getPurchases() async {
    List<PurchasedItem> items =
    await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }
    print('get purchases');
    _items.assignAll([]);
    _purchases.assignAll(items);
  }

  Future getPurchaseHistory() async {
    List<PurchasedItem> items = await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }
    print('get history');
      _items.assignAll([]);
      _purchases.assignAll(items);

  }


}


