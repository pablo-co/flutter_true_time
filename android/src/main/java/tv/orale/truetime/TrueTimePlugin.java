package tv.orale.truetime;

import android.util.Log;

import com.instacart.library.truetime.TrueTimeRx;

import java.util.Date;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.functions.Consumer;
import io.reactivex.functions.Action;
import io.reactivex.schedulers.Schedulers;

/**
 * TrueTimePlugin
 */
public class TrueTimePlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "true_time");
        channel.setMethodCallHandler(new TrueTimePlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, final Result result) {
        switch (call.method) {
            case "init":
                TrueTimeRx.build()
                        .withConnectionTimeout(1_000)
                        .withRetryCount(3)
                        .withLoggingEnabled(true)
                        .initializeRx("time.google.com")
                        .subscribeOn(Schedulers.io())
                        .observeOn(AndroidSchedulers.mainThread())
                        .subscribe(new Consumer<Date>() {
                            @Override
                            public void accept(Date date) {
                                if (!TrueTimeRx.isInitialized()) {
                                    return;
                                }
                                result.success(true);
                            }
                        }, new Consumer<Throwable>() {
                            @Override
                            public void accept(Throwable e) {
                                result.error("Error initializing TrueTime", e.getMessage(), false);
                            }
                        });
                break;
            case "now":
                result.success(TrueTimeRx.now().getTime());
                break;
            default:
                result.notImplemented();
        }
    }
}
