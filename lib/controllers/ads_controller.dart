import 'dart:async';
import 'dart:convert';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_inapp_purchase/modules.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_core_flutter/pa_core_flutter.dart';
import 'package:mods_guns/app/modules/main_module/main_controller.dart';
import 'package:mods_guns/constants/const_url.dart';
import 'package:mods_guns/utils/ad_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'native_ad_controller_new.dart';

NativeAdControllerNew nativeDetailAdControllerNew;
NativeAdControllerNew nativeHomeAdControllerNew;
AdsController adsCtrl;

class AdsController extends GetxController {
  final isPremium = false.obs;
  static bool initPurchase = false;
  final box = GetStorage();
  final isLoaded = false.obs;

  //region purchase
  StreamSubscription purchaseUpdatedSubscription;
  StreamSubscription purchaseErrorSubscription;
  final List<String> _productLists =
      GetPlatform.isAndroid ? ['premium'] : ['premium_yugioh'];
  final _platformVersion = 'Unknown'.obs;
  final items = <IAPItem>[].obs;
  final purchases = <PurchasedItem>[].obs;

  bool getPremium() {
    bool check = box.read('IS_PREMIUM');
    update();
    return check;
  }

  //endregion
  //region ads
  String a = "test";

  final count = 0.obs;
  var countInterAdRequest = 0.obs;
  var countBannerAdRequest = 0.obs;
  var countNativeAdRequest = 0.obs;
  var countRewardedAdRequest = 0.obs;

  AdRequest adRequest = AdRequest(testDevices: [
    'C53C9F562E282082EAFCDB42BF360BC1', //may 3
    '79A2C46F7F42017B2CD92F43970F4F2F',
    'e645b85f78980a92381fe225e3df5aec',
    '5D0652DC72425F6CECA87D81F7962752', // k30 pro
    'AA3C4BE53741CB6307F0D3BEE858788C',
    'AE5B78ECB6B4C81A22C84C8C495AD475',
    'D1A4C2C5098720AC896B9A73B4B35A56',
    'DA8D0C15BC39C0492A0E36ABA922EDC2',
    '4A50245291F2A618FEA096DE31D72C62',
    'f8323379feb22fa26dcceb6ffc9a3841',
    '4ef4c95ec1b16bba8f690c014a724c08',
    '37383e7fb3ef7121f81cac2d25ddf8b5',
    'kGADSimulatorID'
  ]);

  // NativeAd myNativeAd;
  // Completer nativeAdCompleter;

  // loadNative() => myNativeAd.load();

  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;

  RewardedAd _rewardedAd;
  bool _rewardedReady = false;

  showIntersAds() {
    if (!_interstitialReady) return;
    if (isPremium.value) return;
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
          countInterAdRequest.value++;
          if (countInterAdRequest.value > 3) return;
          Future.delayed(Duration(seconds: 60), () {
            _interstitialAd = null;
            createInterstitialAd();
          });
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

  showRewardedAd() {
    if (!_rewardedReady) return;
    _rewardedAd.show();
    _rewardedReady = false;
    _rewardedAd = null;
  }

  void createRewardedAd() {
    _rewardedAd ??= RewardedAd(
      adUnitId: AdManager.rewardedAdUnitId,
      request: adRequest,
      listener: AdListener(
          onAdLoaded: (Ad ad) {
            print('${ad.runtimeType} loaded.');
            _rewardedReady = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('${ad.runtimeType} failed to load: $error');
            ad.dispose();
            countRewardedAdRequest.value++;
            if (countRewardedAdRequest.value > 3) return;
            Future.delayed(Duration(seconds: 60), () {
              _rewardedAd = null;
              createRewardedAd();
            });
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
            count.value++;
          }),
    )..load();
  }

  //endregion

  initDetailAds() {
    if (nativeDetailAdControllerNew == null) {
      nativeDetailAdControllerNew = NativeAdControllerNew();
      nativeDetailAdControllerNew.initAds(
          initNumberAds: 1,
          maxCountAds: 2,
          maxCallRequest: 3,
          forceRefresh: false,
          adUnitId: AdManager.nativeAdUnitId,
          options: new NativeAdsOption(type: 'NativeAdDetail'));
    }
  }

  initHomeAds() {
    if (nativeHomeAdControllerNew == null) {
      nativeHomeAdControllerNew = NativeAdControllerNew();
      nativeHomeAdControllerNew.initAds(
          initNumberAds: 2,
          maxCountAds: 3,
          maxCallRequest: 3,
          forceRefresh: false,
          adUnitId: AdManager.nativeAdUnitId,
          options: new NativeAdsOption(type: 'NativeAdHome'));
      print(nativeHomeAdControllerNew.listAds.length.toString() + 'abcdef');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    myBanner?.dispose();
    myBanner = null;
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    // myNativeAd?.dispose();
    // myNativeAd = null;
    purchaseUpdatedSubscription.cancel();
    purchaseErrorSubscription.cancel();
    super.onClose();
  }

  @override
  void onReady() async {
    print('ready');

    print('data: ' + box.hasData('MAX_AD_CONTENT').toString());
    try {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      IosDeviceInfo info = await deviceInfoPlugin.iosInfo;
      if (GetPlatform.isIOS &&
          double.parse(info.systemVersion.split(".").first) >= 14.0) {
        await AppTrackingTransparency.requestTrackingAuthorization()
            .then((value) {
          saveKeyToSharedPref();
          print('appTrackingTransparency: $value');
        });
      }
    } catch (e) {
      print('requestTrackingAuthorization ios 14 or higher');
    }

    if (!box.hasData('MAX_AD_CONTENT')) {
      if (GetPlatform.isAndroid)
        await PACoreShowDialog.pickYearDialog(Get.context);
    }

    MobileAds.instance
        .updateRequestConfiguration(RequestConfiguration(
            maxAdContentRating: GetPlatform.isAndroid
                ? box.read("MAX_AD_CONTENT")
                : 'MAX_AD_CONTENT_RATING_MA',
            tagForChildDirectedTreatment:
                TagForChildDirectedTreatment.unspecified))
        .whenComplete(() {
      initDetailAds();
      initHomeAds();
      initBannerAds();
      createInterstitialAd();
      // createRewardedAd();
    });
  }

  saveKeyToSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('IS_NOT_FIRST', true);
  }

  purchased() {
    if (isPremium.value == false) {
      isPremium.value = true;
      print('purchased');
      box.write('IS_PREMIUM', isPremium.value);
    }
  }

  Completer completerItemAds = Completer<BannerAd>();
  BannerAd myBanner;
  var list = <BannerAd>[].obs;

  loadBanner() => myBanner.load();
  initBannerAds() {
    myBanner = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.getSmartBanner(Orientation.portrait),
      request: adRequest,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          list.assignAll([ad as BannerAd]);
          print('ad type: ' + box.read("MAX_AD_CONTENT"));
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('BannerAd failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
    );

    myBanner.load();
  }

//region purchase
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

    purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      print('purchase-updated: $productItem');
      validate(productItem);
    });

    purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });

    await getProduct();
    await getPurchaseHistory();
    initPurchase = true;
  }

  static Future validate(PurchasedItem productItem) async {
    Map transactionReceipt = jsonDecode(productItem.transactionReceipt);
    print(
        "transactionReceipt['packageName'] ${transactionReceipt['packageName']}");
    print("transactionReceipt['productId'] ${transactionReceipt['productId']}");
    var result = await FlutterInappPurchase.instance.validateReceiptAndroid(
      packageName: transactionReceipt['packageName'],
      productId: transactionReceipt['productId'],
      productToken: productItem.purchaseToken,
      accessToken: accessToken,
      isSubscription: false,
    );
    print("validateReceiptAndroid result ${result.body}");
    return true;
  }

  void requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future getProduct() async {
    List<IAPItem> listItems =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in listItems) {
      print('get items');
      print('${item.toString()}');
      this.items.add(item);
    }
    print('get products');
    items.assignAll(listItems);
    purchases.assignAll([]);
  }

  Future getPurchases() async {
    List<PurchasedItem> listItems =
        await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in listItems) {
      print('${item.toString()}');
      this.purchases.add(item);
    }
    print('get purchases');
    // items.assignAll([]);
    purchases.assignAll(listItems);
  }

  Future getPurchaseHistory() async {
    List<PurchasedItem> listItems =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in listItems) {
      print('${item.toString()}');
    }
    print('get history');
    purchases.assignAll(listItems);
    print(purchases);
  }

  //endregion
}

class NativeAdsController {
  Completer<NativeAd> completer;
  NativeAd ad;
  bool isUsing = false;
  NativeAdsController(this.completer, {this.ad, this.isUsing = false});
}

class NativeAdsOption {
  final String type;
  NativeAdsOption({this.type});
  Map<String, Object> toJson() {
    var map = {'type': type};
    return map;
  }
}
