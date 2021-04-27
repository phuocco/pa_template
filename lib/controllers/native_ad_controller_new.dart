import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/controllers/ads_controller.dart';

class NativeAdControllerNew {
  NativeAdControllerNew();

  int _maxCountAds;
  int _maxCountRequest;
  bool _forceRefresh;
  String _adUnitId;
  NativeAdsOption _optionsAds;
  AdRequest _adRequest = AdsController().adRequest;

  List<Completer<NativeAd>> _listAds = [];
  int _indexCurrentAds = 0;
  int _countRequest = 0;

//region initAds
  void initAds(
      {int maxCountAds = 1,
      int maxCallRequest = 3,
      bool forceRefresh = true,
      @required String adUnitId,
      @required NativeAdsOption options}) {
    _maxCountAds = maxCountAds;
    _maxCountRequest = maxCallRequest;
    _forceRefresh = forceRefresh;
    _adUnitId = adUnitId;
    _optionsAds = options;
    print('_maxCountAds $_maxCountAds');
    _getAds(options);
  }

//region getAd
  getAdsByIncreaseIndex({int index}) {
    print('ad');
    try {
      var _itemAd;
      if (_listAds.length == 1) {
        _itemAd = _listAds[0];
      } else {
        if (index == null) {
          _itemAd = _listAds[_indexCurrentAds];
          _indexCurrentAds++;
          if (_indexCurrentAds >= _listAds.length) {
            _indexCurrentAds = 0;
          }
        } else {
          if (index >= _listAds.length) {
            _itemAd = _listAds[0];
          } else {
            _itemAd = _listAds[index];
          }
        }
      }
      return _itemAd;
    } catch (e) {
      print(e.toString());
    }
  }

  _getAds(NativeAdsOption options) {
    if (_maxCountAds == 1) {
      _getItemAds(options);
    } else {
      _getListAds(options);
    }
  }
//endregion

//region requestAds
  void requestAds() {
    try {
      if (_countRequest >= _maxCountRequest) {
        if (_forceRefresh) {
          _clearListAds();
          _getListAds(_optionsAds);
        } else {
          _getItemAds(_optionsAds);
        }
        _countRequest = 0;
      } else {
        _countRequest++;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _clearListAds() {
    _listAds.clear();
  }

  _getListAds(NativeAdsOption options) {
// "Max Count Ads: $_maxCountAds".adsData;
    for (var i = 0; i < _maxCountAds; i++) {
      Completer completerItemAds = Completer<NativeAd>();
      NativeAd myNativeAd = NativeAd(
        adUnitId: _adUnitId,
        request: _adRequest,
        factoryId: 'adFactoryId',
        customOptions: options.toJson(),
        listener: AdListener(
          onAdLoaded: (Ad ad) {
            print('$NativeAd loaded.. purchase');
            completerItemAds.complete(ad as NativeAd);
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('$NativeAd failedToLoad: $error');
            completerItemAds.completeError(error);
          },
          onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
          onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
          onApplicationExit: (Ad ad) => print('$NativeAd onApplicationExit.'),
        ),
      );
      Future<void>.delayed(Duration(seconds: 1), () => myNativeAd?.load());
      _listAds.add(completerItemAds);
    }
  }

  _getItemAds(NativeAdsOption options) {
    Completer completerItemAds = Completer<NativeAd>();
    NativeAd myNativeAd = NativeAd(
      adUnitId: _adUnitId,
      request: _adRequest,
      factoryId: 'adFactoryId',
      customOptions: options.toJson(),
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.. purchase');
          completerItemAds.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          completerItemAds.completeError(error);
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$NativeAd onApplicationExit.'),
      ),
    );
    Future<void>.delayed(Duration(seconds: 1), () => myNativeAd?.load());
    _listAds.removeAt(0);
    _listAds.add(completerItemAds);
  }
//endregion

}
