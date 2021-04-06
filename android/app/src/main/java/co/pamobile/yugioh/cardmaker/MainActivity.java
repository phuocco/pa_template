package co.pamobile.yugioh.cardmaker;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;


import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.Uri;
import android.util.Log;
import android.view.LayoutInflater;
import android.widget.TextView;

import androidx.core.content.FileProvider;

import com.google.android.gms.ads.formats.UnifiedNativeAd;
import com.google.android.gms.ads.formats.UnifiedNativeAdView;

import java.io.File;
import java.util.Map;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "addons/detail";
    String fullPath;
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),CHANNEL)
                .setMethodCallHandler(
                        ((call, result) -> {
                            if (call.method.equals("install")) {
                                fullPath = call.arguments.toString();
                                Log.e("test", fullPath);
                                if (!fullPath.isEmpty()) {
                                    sendToMC(MainActivity.this, new File(fullPath));
                                }
                                Log.e("test", "android side");
                                result.success(true);
                            } else {
                                result.notImplemented();
                            }
                        })
                );

        final NativeAdFactory factory = new NativeAdFactoryExample(getLayoutInflater());
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "adFactoryExample", factory);
    }

    @Override
    public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample");
    }


    void sendToMC(Activity activity, File file){
        PackageManager packageManager = activity.getPackageManager();
        Intent i = packageManager.getLaunchIntentForPackage("com.mojang.minecraftpe");
        i.setAction(Intent.ACTION_VIEW);
        i.setFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION);
        i.setType("file/*");
        Uri uri = FileProvider.getUriForFile(activity, activity.getPackageName()+".fileProvider", file);
        activity.grantUriPermission(activity.getApplicationContext().getPackageName(),uri,Intent.FLAG_GRANT_WRITE_URI_PERMISSION | Intent.FLAG_GRANT_READ_URI_PERMISSION);
        i.setDataAndType(uri,"application/octet-stream");
        i.addCategory(Intent.CATEGORY_DEFAULT);
        activity.startActivity(i);
    }

}

class NativeAdFactoryExample implements NativeAdFactory {
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