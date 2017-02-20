package cl.json.social;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReadableMap;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import cl.json.ShareFile;

/**
 * Created by disenodosbbcl on 23-07-16.
 */
public class SingleShareIntent {
    private ReactApplicationContext context;
    private String packageName;
    private String playStoreURL;

    public SingleShareIntent(ReactApplicationContext context, String packageName,
                             String playStoreURL) {
        this.context = context;
        this.packageName = packageName;
        this.playStoreURL = playStoreURL;
    }

    public void open(String message) throws ActivityNotFoundException {
        this.open(null, message, null);
    }

    public void openUrl(String url) throws ActivityNotFoundException {
        this.open(null, null, url);
    }

    public void open(String subject, String message) throws ActivityNotFoundException {
        this.open(subject, message, null);
    }

    public void open(String subject, String message, String url) throws ActivityNotFoundException {
        Intent intent;
        if (isPackageInstalled(packageName)) {
            intent = new Intent(Intent.ACTION_SEND);
            intent.setType("text/plain");
            intent.setPackage(packageName);

            if (subject != null) {
                intent.putExtra(Intent.EXTRA_SUBJECT, subject);
            }
            if (message != null) {
                intent.putExtra(Intent.EXTRA_TEXT, message);
            }
            if (url != null) {
                intent.putExtra(Intent.EXTRA_TEXT, url);
            }
        } else if (playStoreURL != null) {
            intent = new Intent(Intent.ACTION_VIEW, Uri.parse(playStoreURL));
        } else {
            throw new ActivityNotFoundException();
        }

        Intent chooser = Intent.createChooser(intent, "Share");
        chooser.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        this.context.startActivity(chooser);
    }

    private boolean isPackageInstalled(String packageName) {
        try {
            context.getPackageManager().getPackageInfo(packageName, PackageManager.GET_ACTIVITIES);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }
}
