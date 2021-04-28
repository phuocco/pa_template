import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pa_template/controllers/ads_controller.dart';

class NativeAdControllerNew {
  NativeAdControllerNew();

  int _maxCountAds;
  int _maxCountRequest;
  int _initNumberAds;
  bool _forceRefresh;
  String _adUnitId;
  NativeAdsOption _optionsAds;
  AdRequest _adRequest = AdsController().adRequest;

  List<Completer<NativeAd>> _listAds = [];


  List<Completer<NativeAd>> get listAds => _listAds;

  int _indexCurrentAds = 0;
  int _countRequest = 0;

//region initAds
  void initAds(
      {int maxCountAds = 1,
      int maxCallRequest = 3,
      int initNumberAds = 1,
      bool forceRefresh = true,
      @required String adUnitId,
      @required NativeAdsOption options}) {
    _maxCountAds = maxCountAds;
    _maxCountRequest = maxCallRequest;
    _initNumberAds = initNumberAds;
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
      'Count Request $_countRequest'.adsData;
      'Max Count Request $_maxCountRequest'.adsData;
      if (_countRequest >= _maxCountRequest) {
        if (_forceRefresh) {
          _clearListAds();
          'length ${_listAds.length}'.adsData;
          _getListAds(_optionsAds);
        } else {
          // if(_initNumberAds<_maxCountAds){
          //   _getItemAds(_optionsAds, addItem: true);
          // } else {
            _getItemAds(_optionsAds);
          // }
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
    for (var i = 0; i < _initNumberAds; i++) {
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
            "New Ads: ${ad.hashCode}".adsData;
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

  _getItemAds(NativeAdsOption options, {bool addItem = false}) {
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
          "New Ads Detail: ${ad.hashCode}".adsData;

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
    // if(_listAds.length>0 && !addItem){
    //   _listAds.removeAt(0);
    // }
    if (_listAds.length >= _maxCountAds){
      _listAds.removeAt(0);
    }
    "length ${_listAds.length}".adsData;
    _listAds.add(completerItemAds);
  }
//endregion

}
extension DebugAds on String {
  void get adsFlow => log(this, name: 'Ads Flow', level: 1);
  void get adsError => log(this, name: 'Ads Error', level: 2);
  void get adsData => log(this, name: 'Ads Data', level: 3);
  void get adsState => log(this, name: 'Ads State', level: 4);
}
