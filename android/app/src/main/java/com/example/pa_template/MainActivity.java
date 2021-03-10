package com.example.pa_template;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;


import android.graphics.Color;
import android.view.LayoutInflater;
import android.widget.TextView;
import com.google.android.gms.ads.formats.UnifiedNativeAd;
import com.google.android.gms.ads.formats.UnifiedNativeAdView;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;
import java.util.Map;


public class MainActivity extends FlutterActivity {

    private NativeAdFactoryExample nativeAdFactoryExample;

    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        flutterEngine.getPlugins().add(new GoogleMobileAdsPlugin());
        super.configureFlutterEngine(flutterEngine);

        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "adFactoryExample",nativeAdFactoryExample);
    }
    @Override
    public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample");
    }
}

class NativeAdFactoryExample implements GoogleMobileAdsPlugin.NativeAdFactory {
    private final LayoutInflater layoutInflater;

    NativeAdFactoryExample(LayoutInflater layoutInflater) {
        this.layoutInflater = layoutInflater;
    }

    @Override
    public UnifiedNativeAdView createNativeAd(
            UnifiedNativeAd nativeAd, Map<String, Object> customOptions) {
        final UnifiedNativeAdView adView =
                (UnifiedNativeAdView) layoutInflater.inflate(R.layout.my_native_ad, null);
        final TextView headlineView = adView.findViewById(R.id.ad_headline);
        final TextView bodyView = adView.findViewById(R.id.ad_body);

        headlineView.setText(nativeAd.getHeadline());
        bodyView.setText(nativeAd.getBody());

        adView.setBackgroundColor(Color.YELLOW);

        adView.setNativeAd(nativeAd);
        adView.setBodyView(bodyView);
        adView.setHeadlineView(headlineView);
        return adView;
    }
}