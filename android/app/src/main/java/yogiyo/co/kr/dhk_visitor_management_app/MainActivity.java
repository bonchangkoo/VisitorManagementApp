package yogiyo.co.kr.dhk_visitor_management_app;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "kr.co.deliveryhero/GoogleSheetApi";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                if (call.method.equals("hello")) {
                  String str = (String)call.arguments;
                  Log.d("flutter", str);
                  result.success("Hello from Native");
                } else {
                  result.notImplemented();
                }
              }
            }
    );
  }
}
