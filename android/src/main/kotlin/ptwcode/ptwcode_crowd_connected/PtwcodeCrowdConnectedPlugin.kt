package ptwcode.ptwcode_crowd_connected

import android.app.Application
import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import net.crowdconnected.android.core.ConfigurationBuilder
import net.crowdconnected.android.core.CrowdConnected
import net.crowdconnected.android.core.StatusCallback
import net.crowdconnected.android.geo.GeoModule
import net.crowdconnected.android.ips.IPSModule

/** PtwcodeCrowdConnectedPlugin */
class PtwcodeCrowdConnectedPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mApplication : Application

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ptwcode_crowd_connected")
    channel.setMethodCallHandler(this)
    mApplication =  flutterPluginBinding.applicationContext as Application;
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "start"){
      startService(call);
      return;
    }
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun startService(call: MethodCall) {
    
    val appKey: String = (call.arguments as Map<String,String>)["app_key"] as String;
    val publicToken: String = (call.arguments as Map<String,String>)["public_token"] as String;
    val secretToken: String = (call.arguments as Map<String,String>)["secret_token"] as String;

    val configuration = ConfigurationBuilder()
      .withAppKey(appKey)
      .withToken(publicToken)
      .withSecret(secretToken)
      .withServiceNotificationInfo("Crowd Connected BD", R.drawable.common_full_open_on_phone)
      .withStatusCallback(CustomStatusCallback())
      .addModule(GeoModule())
      .addModule(IPSModule())
      .build()

    CrowdConnected.start(mApplication, configuration)
  }
}


class CustomStatusCallback : StatusCallback {
  override fun onStartUpFailure(p0: String?) {
    Log.i("onStartUpFailure", "onStartUpFailure: $p0")
  }

  override fun onStartUpSuccess() {
    Log.i("onStartUpSuccess", "onStartUpSuccess")
  }
}
