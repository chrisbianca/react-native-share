package cl.json;

import android.content.ActivityNotFoundException;
import android.provider.Telephony;
import android.support.annotation.Nullable;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.Callback;

import cl.json.social.GenericShare;
import cl.json.social.SingleShareIntent;

public class RNShareModule extends ReactContextBaseJavaModule {

    public RNShareModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
    return "RNShare";
    }

    @ReactMethod
    public void open(ReadableMap options, @Nullable Callback failureCallback, @Nullable Callback successCallback) {
        try{
            GenericShare share = new GenericShare(this.getReactApplicationContext());
            share.open(options);
            successCallback.invoke("OK");
        }catch(ActivityNotFoundException ex) {
            failureCallback.invoke("not_available");
        }
    }
    @ReactMethod
    public void shareSingle(ReadableMap options, @Nullable Callback failureCallback, @Nullable Callback successCallback) {
        try {
            String social = options.getString("social");
            if (social == null) {
                failureCallback.invoke("Options must include a 'social' key");
                return;
            }

            String subject = extractKey(options, "subject");
            String message = extractKey(options, "message");
            String url = extractKey(options, "url");

            if (url != null && message != null && message.contains("--url--")) {
                message = message.replace("--url--", url);
            } else if (url != null && message != null) {
                message = message + " " + url;
            } else if (url != null) {
                message = url;
            }

            SingleShareIntent shareIntent;
            if ("facebook".equals(social)) {
                shareIntent = new SingleShareIntent(this.getReactApplicationContext(), "com.facebook.katana", null);
                shareIntent.open(message);
            } else if ("twitter".equals(social)) {
                shareIntent = new SingleShareIntent(this.getReactApplicationContext(), "com.twitter", null);
                shareIntent.open(message);
            } else if ("googleplus".equals(social)) {
                shareIntent = new SingleShareIntent(this.getReactApplicationContext(), "com.google.android.apps.plus", null);
                shareIntent.open(message);
            } else if ("whatsapp".equals(social)) {
                shareIntent = new SingleShareIntent(this.getReactApplicationContext(), "com.whatsapp", null);
                shareIntent.open(message);
            } else if ("email".equals(social)) {
                shareIntent = new SingleShareIntent(this.getReactApplicationContext(), "com.android.email", null);
                shareIntent.open(subject, message);
            } else if ("gmail".equals(social)) {
                shareIntent = new SingleShareIntent(this.getReactApplicationContext(), "com.google.android.gm", null);
                shareIntent.open(subject, message);
            } else if ("sms".equals(social)) {
                String packageName = Telephony.Sms.getDefaultSmsPackage(this.getReactApplicationContext());;
                shareIntent = new SingleShareIntent(this.getReactApplicationContext(), packageName, null);
                shareIntent.open(message);
            } else if ("fb-messenger".equals(social)) {
                shareIntent = new SingleShareIntent(this.getReactApplicationContext(), "com.facebook.orca", null);
                shareIntent.open(message);
            } else {
                failureCallback.invoke("Invalid 'social' key");
                return;
            }
            successCallback.invoke("OK");
        } catch (ActivityNotFoundException ex) {
            failureCallback.invoke(ex.getMessage());
        }
    }

    private String extractKey(ReadableMap options, String key) {
        if (options.hasKey(key) && !options.isNull(key)) {
            return options.getString(key);
        }
        return null;
    }
}
