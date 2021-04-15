package co.pamobile.yugioh.cardmaker;

import android.graphics.Color;
import android.view.LayoutInflater;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.gms.ads.formats.UnifiedNativeAd;
import com.google.android.gms.ads.formats.UnifiedNativeAdView;
import com.google.android.gms.ads.formats.MediaView;

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
        final UnifiedNativeAdView adView =
                (UnifiedNativeAdView) layoutInflater.inflate(R.layout.native_home_view, null);

        final TextView headlineView = adView.findViewById(R.id.ad_headline);
        final TextView bodyView = adView.findViewById(R.id.ad_body);
//        final ImageView iconView = adView.findViewById(R.id.ad_icon);
        final MediaView mediaView = adView.findViewById(R.id.ad_media);
        final Button buttonView = adView.findViewById(R.id.ad_call_to_action);

        headlineView.setText(nativeAd.getHeadline()+ " asdasd asd asd asd ");
        bodyView.setText(nativeAd.getBody());

//        if(nativeAd.getIcon() != null){
//            iconView.setImageDrawable(nativeAd.getIcon().getDrawable());
//        }
        buttonView.setText(nativeAd.getCallToAction());

        mediaView.setMediaContent(nativeAd.getMediaContent());
        adView.setMediaView(mediaView);
        adView.getMediaView().setMediaContent(nativeAd.getMediaContent());



        adView.setBackgroundColor(Color.TRANSPARENT);
        adView.setNativeAd(nativeAd);
        adView.setBodyView(bodyView);
        adView.setHeadlineView(headlineView);
//        adView.setIconView(iconView);
        adView.setMediaView(mediaView);
        adView.setCallToActionView(buttonView);
        return adView;
    }
}
