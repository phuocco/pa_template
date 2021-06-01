package co.pamobile.mcpe.mods.guns;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;

import androidx.lifecycle.LifecycleObserver;
import androidx.lifecycle.OnLifecycleEvent;
import androidx.lifecycle.ProcessLifecycleOwner;

import com.google.android.gms.ads.AdError;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.FullScreenContentCallback;
import com.google.android.gms.ads.LoadAdError;
import com.google.android.gms.ads.appopen.AppOpenAd;

import java.util.Date;

import static androidx.lifecycle.Lifecycle.Event.ON_START;

/** Prefetches App Open Ads. */
public class AppOpenManager implements LifecycleObserver, Application.ActivityLifecycleCallbacks {
    private static final String LOG_TAG = "AppOpenManager";
    private static final String AD_UNIT_ID = "ca-app-pub-9131188183332364/6976372665";
    private AppOpenAd appOpenAd = null;
    private Activity currentActivity;
    private AppOpenAd.AppOpenAdLoadCallback loadCallback;

    private final MyApplication myApplication;
    private long loadTime = 0;
    private static boolean isShowingAd = false;
    boolean premium = false;

    /** Constructor */
    public AppOpenManager(MyApplication myApplication) {
        this.myApplication = myApplication;
        this.myApplication.registerActivityLifecycleCallbacks(this);
        ProcessLifecycleOwner.get().getLifecycle().addObserver(this);
    }


    /** Shows the ad if one isn't already showing. */
    public void showAdIfAvailable() {
        // Only show ad if there is not already an app open ad currently showing
        // and an ad is available.
        if (!isShowingAd && isAdAvailable()) {
            Log.d(LOG_TAG, "Will show ad.");

            FullScreenContentCallback fullScreenContentCallback =
                    new FullScreenContentCallback() {
                        @Override
                        public void onAdDismissedFullScreenContent() {
                            // Set the reference to null so isAdAvailable() returns false.
                            AppOpenManager.this.appOpenAd = null;
                            isShowingAd = false;
                            fetchAd(false);
                        }

                        @Override
                        public void onAdFailedToShowFullScreenContent(AdError adError) {}

                        @Override
                        public void onAdShowedFullScreenContent() {
                            isShowingAd = true;
                        }
                    };


            if(isFirstTime()){
                return;
            }
            if(!isPremium()){
                appOpenAd.show(currentActivity, fullScreenContentCallback);
            }

        } else {
            Log.d(LOG_TAG, "Can not show ad.");
            fetchAd(true);
        }
    }

    boolean isPremium(){
        SharedPreferences sharedPref = myApplication.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
        premium = sharedPref.getBoolean("flutter.IS_PREMIUM",false);
        Log.d(LOG_TAG, "ispremium " + Boolean.toString(premium));
        return premium;
    }
    boolean isFirstTime(){
        SharedPreferences sharedPref = myApplication.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
        boolean isFirstTime = sharedPref.getBoolean("isFirstTime",true);
        if(isFirstTime){
            sharedPref.edit().putBoolean("isFirstTime", false).apply();
            boolean isFirstTime2 = sharedPref.getBoolean("isFirstTime",true);
        }
        return isFirstTime;
    }

    /** Request an ad */
    public void fetchAd(boolean showAd) {
        // Have unused ad, no need to fetch another.
        if (isAdAvailable()) {
            return;
        }

        loadCallback =
                new AppOpenAd.AppOpenAdLoadCallback() {
                    /**
                     * Called when an app open ad has loaded.
                     *
                     * @param ad the loaded app open ad.
                     */
                    @Override
                    public void onAppOpenAdLoaded(AppOpenAd ad) {
                        AppOpenManager.this.appOpenAd = ad;
                        AppOpenManager.this.loadTime = (new Date()).getTime();


                        if(ad != null && showAd){
                            FullScreenContentCallback fullScreenContentCallback =
                                    new FullScreenContentCallback() {
                                        @Override
                                        public void onAdDismissedFullScreenContent() {
                                            // Set the reference to null so isAdAvailable() returns false.
                                            AppOpenManager.this.appOpenAd = null;
                                            isShowingAd = false;
                                            fetchAd(false);
                                        }

                                        @Override
                                        public void onAdFailedToShowFullScreenContent(AdError adError) {}

                                        @Override
                                        public void onAdShowedFullScreenContent() {
                                            isShowingAd = true;
                                        }
                                    };
                            if(isFirstTime()){
                                return;
                            }
                            if(!isPremium()){
                                appOpenAd.show(currentActivity, fullScreenContentCallback);
                            }
                        }


                    }

                    /**
                     * Called when an app open ad has failed to load.
                     *
                     * @param loadAdError the error.
                     */
                    @Override
                    public void onAppOpenAdFailedToLoad(LoadAdError loadAdError) {
                        // Handle the error.
                    }

                };
        AdRequest request = getAdRequest();
        AppOpenAd.load(
                myApplication, AD_UNIT_ID, request,
                AppOpenAd.APP_OPEN_AD_ORIENTATION_PORTRAIT, loadCallback);
    }

    /** Creates and returns ad request. */
    private AdRequest getAdRequest() {
        return new AdRequest.Builder().addTestDevice("5D0652DC72425F6CECA87D81F7962752").build();
    }

    /** Utility method that checks if ad exists and can be shown. */
    public boolean isAdAvailable() {
        return appOpenAd != null && wasLoadTimeLessThanNHoursAgo(1);
    }
    /** Utility method to check if ad was loaded more than n hours ago. */
    private boolean wasLoadTimeLessThanNHoursAgo(long numHours) {
        long dateDifference = (new Date()).getTime() - this.loadTime;
        long numMilliSecondsPerHour = 3600000;
        return (dateDifference < (numMilliSecondsPerHour * numHours));
    }
    /** LifecycleObserver methods */
    @OnLifecycleEvent(ON_START)
    public void onStart() {
        showAdIfAvailable();
        Log.d(LOG_TAG, "onStart");
    }

    /** ActivityLifecycleCallback methods */
    @Override
    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {}

    @Override
    public void onActivityStarted(Activity activity) {
        currentActivity = activity;
    }

    @Override
    public void onActivityResumed(Activity activity) {
        currentActivity = activity;
    }

    @Override
    public void onActivityStopped(Activity activity) {}

    @Override
    public void onActivityPaused(Activity activity) {}

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle bundle) {}

    @Override
    public void onActivityDestroyed(Activity activity) {
        currentActivity = null;
    }
}