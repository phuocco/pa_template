//
//  NativeAdFactoryExample.swift
//  Runner
//
//  Created by Phuoc Nguyen on 3/11/21.
//

import Foundation
import google_mobile_ads
import MobileCoreServices
import GoogleMobileAds

class NativeAdFactoryAddon: NSObject, FLTNativeAdFactory {
    

    func createNativeAd(_ nativeAd: GADUnifiedNativeAd, customOptions: [AnyHashable : Any]? = nil) -> GADUnifiedNativeAdView? {
        // Create and place ad in view hierarchy.
        var adView:GADUnifiedNativeAdView? = nil
        if let dict = customOptions as NSDictionary? as! [String:Any]? {
          print(dict["type"]!)
            adView = (Bundle.main.loadNibNamed(dict["type"]! as! String, owner: nil, options: nil)?.first as? GADUnifiedNativeAdView)!

        } else {
            adView = (Bundle.main.loadNibNamed("UnifiedNativeAdView", owner: nil, options: nil)?.first as? GADUnifiedNativeAdView)!
        }

        adView?.nativeAd = nativeAd

        (adView?.headlineView as? UILabel)?.text = nativeAd.headline

        (adView?.bodyView as? UILabel)?.text = nativeAd.body
        adView?.bodyView?.isHidden = (nativeAd.body != nil) ? false : true

        (adView?.callToActionView as? UIButton)?.setTitle(
            nativeAd.callToAction,
            for: .normal)
        adView?.callToActionView?.isHidden = (nativeAd.callToAction != nil) ? false : true

        return adView
    }
}
