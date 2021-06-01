import 'dart:io';

class AdManager {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364~8777747685";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9131188183332364~7111164996";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364/4838502675";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9131188183332364/9864486692";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364/7273094329";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9131188183332364/8087482543";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9131188183332364/3333849314";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9131188183332364/7512767476";
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
