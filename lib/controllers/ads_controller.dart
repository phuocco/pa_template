import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_inapp_purchase/modules.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/constants/const_url.dart';
import 'package:pa_template/utils/ad_manager.dart';

import 'native_ad_controller_new.dart';

NativeAdControllerNew nativeDetailAdControllerNew;
NativeAdControllerNew nativeHomeAdControllerNew;
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

  AdRequest adRequest = AdRequest(testDevices: [
    'C53C9F562E282082EAFCDB42BF360BC1',
    '79A2C46F7F42017B2CD92F43970F4F2F',
    'e645b85f78980a92381fe225e3df5aec',
    '5D0652DC72425F6CECA87D81F7962752',
    'AA3C4BE53741CB6307F0D3BEE858788C',
    'AE5B78ECB6B4C81A22C84C8C495AD475',
    'D1A4C2C5098720AC896B9A73B4B35A56',
    'DA8D0C15BC39C0492A0E36ABA922EDC2'
  ]);

  BannerAd myBanner;
  final bannerCompleter = Completer<BannerAd>().obs;

  loadBanner() => myBanner.load();

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
            count.value++;
          }),
    )..load();
  }

  //endregion


  initDetailAds(){
    if(nativeDetailAdControllerNew == null){
      nativeDetailAdControllerNew = NativeAdControllerNew();
      nativeDetailAdControllerNew.initAds(
          maxCountAds: 1,
          maxCallRequest:3,
          forceRefresh: false,
          adUnitId: AdManager.nativeAdUnitId,
          options: new NativeAdsOption(type: 'NativeAdDetail'));
    }
  }
  initHomeAds(){
    if(nativeHomeAdControllerNew == null){
      nativeHomeAdControllerNew = NativeAdControllerNew();
      nativeHomeAdControllerNew.initAds(
          initNumberAds: 2,
          maxCountAds: 3,
          maxCallRequest:3,
          forceRefresh: false,
          adUnitId: AdManager.nativeAdUnitId,
          options: new NativeAdsOption(type: 'NativeAdHome'));
      print(nativeHomeAdControllerNew.listAds.length.toString() +'abcdef');
    }
  }



  @override
  void onInit() {
    // initPlatformState();
    initDetailAds();
    initHomeAds();
    if (box.read('IS_PREMIUM') == true) {
      isPremium.value = true;
      return;
    }


    initBannerAds();
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
    // myNativeAd?.dispose();
    // myNativeAd = null;
    purchaseUpdatedSubscription.cancel();
    purchaseErrorSubscription.cancel();
    super.onClose();
  }

  @override
  void onReady() {
    print('ready');
  }

  purchased() {
    if (isPremium.value == false) {
      isPremium.value = true;
      print('purchased');
      box.write('IS_PREMIUM', isPremium.value);
    }
  }




//region list detail
  // initNativeAdsDetail(int numAds, NativeAdsOption option) {
  //   for (int i = 0; i < numAds; i++) {
  //     var nativeAdCompleter = Completer<NativeAd>();
  //     var myNativeAd = NativeAd(
  //       adUnitId: AdManager.nativeAdUnitId,
  //       request: adRequest,
  //       factoryId: 'adFactoryId',
  //       customOptions: option.toJson(),
  //       listener: AdListener(
  //         onAdLoaded: (Ad ad) {
  //           print('$NativeAd loaded..');
  //           nativeAdCompleter.complete(ad as NativeAd);
  //           listNativeAdsDetailController
  //               .add(new NativeAdsController(nativeAdCompleter, ad: ad));
  //         },
  //         onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //           print('$NativeAd failedToLoad: $error');
  //           nativeAdCompleter.completeError(null);
  //         },
  //         onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
  //         onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
  //         onApplicationExit: (Ad ad) => print('$NativeAd onApplicationExit.'),
  //       ),
  //     );
  //     Future<void>.delayed(Duration(seconds: 1), () => myNativeAd?.load());
  //     isLoaded.value = true;
  //   }
  //   // loadNative();
  // }
  //endregion

  initBannerAds() {
    myBanner = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.getSmartBanner(Orientation.portrait),
      request: adRequest,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('bannerAd loaded.');
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

    myBanner.load().then((value) => isLoaded.value = true);
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
