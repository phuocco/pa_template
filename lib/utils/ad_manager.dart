import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364~2316564131";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9131188183332364~9179694368";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364/3793297339";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9131188183332364/7511389471";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364/5270030536";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9131188183332364/5240449357";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364/2295206911";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9131188183332364/8632899458";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364/2747800343";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9131188183332364/6303901973";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
