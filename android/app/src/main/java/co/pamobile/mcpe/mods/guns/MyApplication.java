package co.pamobile.mcpe.mods.guns;

import android.util.Log;
import android.widget.Toast;


import com.google.android.gms.ads.MobileAds;
import com.google.android.gms.ads.initialization.InitializationStatus;
import com.google.android.gms.ads.initialization.OnInitializationCompleteListener;

import io.flutter.app.FlutterApplication;

/** The Application class that manages AppOpenManager. */
public class MyApplication extends FlutterApplication {
    private static AppOpenManager appOpenManager;

    @Override
    public void onCreate() {
        super.onCreate();



//         MobileAds.initialize(
//                 this,
//                 initializationStatus -> {});
        appOpenManager = new AppOpenManager(this);


    }
}