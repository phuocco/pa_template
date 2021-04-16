package co.pamobile.yugioh.cardmaker;

import android.graphics.Color;

import java.util.HashMap;

public class GMANativeOption {
    Boolean showMediaContent = true;
    Integer ratingColor = Color.YELLOW;
    GMANativeTextStyle adLabelTextStyle = new GMANativeTextStyle(12f, Color.WHITE, Color.parseColor("#FFCC66"));
    GMANativeTextStyle headlineTextStyle = new GMANativeTextStyle(16f, Color.BLACK);
    GMANativeTextStyle advertiserTextStyle = new GMANativeTextStyle(14f, Color.BLACK);
    GMANativeTextStyle bodyTextStyle = new GMANativeTextStyle(12f, Color.GRAY);
    GMANativeTextStyle storeTextStyle = new GMANativeTextStyle(12f, Color.BLACK);
    GMANativeTextStyle priceTextStyle = new GMANativeTextStyle(12f, Color.BLACK);
    GMANativeTextStyle callToActionStyle = new GMANativeTextStyle(15f, Color.WHITE, Color.parseColor("#4CBE99"));

    void update(HashMap<Object, Object> data) {
        this.showMediaContent = (boolean) data.get("showMediaContent");
        this.ratingColor = (int) Color.parseColor(String.valueOf(data.get("ratingColor")));
        this.adLabelTextStyle.update((HashMap<Object, Object>) data.get("adLabelTextStyle"));
        this.headlineTextStyle.update((HashMap<Object, Object>) data.get("headlineTextStyle"));
        this.advertiserTextStyle.update((HashMap<Object, Object>) data.get("advertiserTextStyle"));
        this.bodyTextStyle.update((HashMap<Object, Object>) data.get("bodyTextStyle"));
        this.storeTextStyle.update((HashMap<Object, Object>) data.get("storeTextStyle"));
        this.priceTextStyle.update((HashMap<Object, Object>) data.get("priceTextStyle"));
        this.callToActionStyle.update((HashMap<Object, Object>) data.get("callToActionStyle"));

    }
}

class GMANativeTextStyle {
    Float fontSize;
    Integer color;
    Integer backgroundColor;
    Boolean isVisible;

    public GMANativeTextStyle(Float fontSize, Integer color, Integer backgroundColor) {
        this.fontSize = fontSize;
        this.color = color;
        this.backgroundColor = backgroundColor;
    }

    public GMANativeTextStyle(Float fontSize, Integer color) {
        this.fontSize = fontSize;
        this.color = color;
    }

    void update(HashMap<Object, Object> data) {
        if (data.get("fontSize") != null) {
            this.fontSize = Float.parseFloat(data.get("fontSize").toString());
        }
        if (data.get("color") != null) {
            this.color = Color.parseColor(String.valueOf(data.get("color")));
        }
        if (data.get("backgroundColor") != null) {
            this.backgroundColor = Color.parseColor(String.valueOf(data.get("backgroundColor")));
        }
        if (data.get(isVisible) != null) {
            this.isVisible = Boolean.parseBoolean(data.get("isVisible").toString());
        } else {
            this.isVisible = true;
        }
    }
}
