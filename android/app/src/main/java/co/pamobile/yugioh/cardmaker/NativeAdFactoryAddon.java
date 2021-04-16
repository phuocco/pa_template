package co.pamobile.yugioh.cardmaker;

import android.graphics.Color;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RatingBar;
import android.widget.TextView;

import com.google.android.gms.ads.formats.UnifiedNativeAd;
import com.google.android.gms.ads.formats.UnifiedNativeAdView;
import com.google.android.gms.ads.formats.MediaView;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;

class NativeAdFactoryAddon implements GoogleMobileAdsPlugin.NativeAdFactory {
    private final LayoutInflater layoutInflater;

    NativeAdFactoryAddon(LayoutInflater layoutInflater) {
        this.layoutInflater = layoutInflater;
    }

    @Override
    public UnifiedNativeAdView createNativeAd(
            UnifiedNativeAd nativeAd, Map<String, Object> customOptions) {
        Log.e("testNative", (String) customOptions.get("type"));
        UnifiedNativeAdView adView =
                (UnifiedNativeAdView) layoutInflater.inflate(R.layout.native_default_view, null);

        String adType = "";
        if (customOptions.containsKey("type")) {
            adType =(String) customOptions.get("type");
            if(!adType.equals("")){
                switch (adType) {
                    case "NativeAdHome":
                        adView = (UnifiedNativeAdView) layoutInflater.inflate(R.layout.native_home_view, null);
                        break;
                    case "NativeAdDetail":
                        adView = (UnifiedNativeAdView) layoutInflater.inflate(R.layout.native_detail_view, null);
                        break;

                    default:
                        throw new IllegalStateException("Unexpected value: " + adType);
                }
            }
        }

        final MediaView mediaView = adView.findViewById(R.id.ad_media);
        final TextView headlineView = adView.findViewById(R.id.ad_headline);
        final TextView advertiser = adView.findViewById(R.id.ad_advertiser);
        final TextView bodyView = adView.findViewById(R.id.ad_body);
        final TextView adPrice = adView.findViewById(R.id.ad_price);
        final TextView adStore = adView.findViewById(R.id.ad_store);
        final TextView adAttribution = adView.findViewById(R.id.ad_attribution);
        final RatingBar adRatingBar = adView.findViewById(R.id.ad_stars);
        final Button callToAction = adView.findViewById(R.id.ad_call_to_action);
        final ImageView iconView = adView.findViewById(R.id.ad_icon);


//        final TextView headlineView = adView.findViewById(R.id.ad_headline);
//        final TextView bodyView = adView.findViewById(R.id.ad_body);
//        final MediaView mediaView = adView.findViewById(R.id.ad_media);
//        final Button buttonView = adView.findViewById(R.id.ad_call_to_action);

        adView.setMediaView(mediaView);
        if (adView.getMediaView() != null) {
            adView.getMediaView().setMediaContent(nativeAd.getMediaContent());
            adView.getMediaView().setImageScaleType(ImageView.ScaleType.FIT_CENTER);
        }
        adView.setCallToActionView(callToAction);
        adView.setIconView(iconView);
        adView.setPriceView(adPrice);
        adView.setStarRatingView(adRatingBar);
        adView.setStoreView(adStore);
        adView.setAdvertiserView(advertiser);
        adView.setBodyView(bodyView);
        adView.setHeadlineView(headlineView);
        adView.setBackgroundColor(Color.TRANSPARENT);
        adView.setNativeAd(nativeAd);

        //fixme: headline
        if (adView.getHeadlineView() != null) {
            if (nativeAd.getHeadline() == null) {
                adView.getHeadlineView().setVisibility(View.INVISIBLE);
            } else {
                  headlineView.setText(nativeAd.getHeadline());
            }
        }

        if (adView.getBodyView() != null) {
            if (nativeAd.getBody() == null) {
                adView.getBodyView().setVisibility(View.INVISIBLE);
            } else {
                bodyView.setText(nativeAd.getBody());
            }
        }

        if (adView.getCallToActionView() != null) {
            if (nativeAd.getCallToAction() == null) {
                adView.getCallToActionView().setVisibility(View.INVISIBLE);
            } else {
                adView.getCallToActionView().setVisibility(View.VISIBLE);
                callToAction.setText(nativeAd.getCallToAction());
            }
        }
        if (adView.getIconView() != null) {
            if (nativeAd.getIcon() == null) {
                adView.getIconView().setVisibility(View.GONE);
            } else {
                iconView.setImageDrawable(nativeAd.getIcon().getDrawable());
                iconView.setVisibility(View.VISIBLE);
            }
        }
        if (adView.getPriceView() != null) {
            if (nativeAd.getPrice() == null) {
                adView.getPriceView().setVisibility(View.INVISIBLE);
            } else {
                adView.getPriceView().setVisibility(View.VISIBLE);
                adPrice.setText(nativeAd.getPrice());

            }
        }

        if (adView.getStoreView() != null) {
            if (nativeAd.getStore() == null) {
                adView.getStoreView().setVisibility(View.INVISIBLE);
            } else {
                adView.getStoreView().setVisibility(View.VISIBLE);
                adStore.setText(nativeAd.getStore());
            }
        }
        if (adView.getStarRatingView() != null) {
            if (nativeAd.getStarRating() == null) {
                adView.getStarRatingView().setVisibility(View.INVISIBLE);
            } else {
              adRatingBar
                        .setRating(nativeAd.getStarRating().floatValue());
                adRatingBar.setVisibility(View.VISIBLE);
            }
        }
        if (adView.getAdvertiserView() != null) {
            if (nativeAd.getAdvertiser() == null) {
                adView.getAdvertiserView().setVisibility(View.INVISIBLE);
            } else {
               advertiser.setText(nativeAd.getAdvertiser());
                adView.getAdvertiserView().setVisibility(View.GONE);
            }
        }




        return adView;


//        headlineView.setText(nativeAd.getHeadline());
//        bodyView.setText(nativeAd.getBody());
//
//
//
//        buttonView.setText(nativeAd.getCallToAction());
//
//        mediaView.setMediaContent(nativeAd.getMediaContent());
//        adView.setMediaView(mediaView);
//        adView.getMediaView().setMediaContent(nativeAd.getMediaContent());
//
//
//
//        adView.setBackgroundColor(Color.TRANSPARENT);
//        adView.setNativeAd(nativeAd);
//        adView.setBodyView(bodyView);
//        adView.setHeadlineView(headlineView);
////        adView.setIconView(iconView);
//        adView.setMediaView(mediaView);
//        adView.setCallToActionView(buttonView);
//        return adView;
    }

}
