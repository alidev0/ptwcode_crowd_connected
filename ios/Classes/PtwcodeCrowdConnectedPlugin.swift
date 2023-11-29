import Flutter
import UIKit
import CrowdConnectedCore
import CrowdConnectedGeo
import CrowdConnectedIPS

public class PtwcodeCrowdConnectedPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ptwcode_crowd_connected", binaryMessenger: registrar.messenger())
    let instance = PtwcodeCrowdConnectedPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
        
    case "start":
        let args:  Dictionary<String,String> = call.arguments as! Dictionary<String, String>
        let appKey: String =   args["app_key"]! as String
        let publicToken: String =   args["public_token"]! as String
        let secretToken: String =   args["secret_token"]! as String
        
        CrowdConnectedGeo.activate()
        CrowdConnectedIPS.activate()
        CrowdConnected.shared.start(appKey: appKey, token: publicToken, secret: secretToken) { deviceId, error in  NSLog("deviceId: \(deviceId)");  NSLog("error: \(error)") }
    
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
