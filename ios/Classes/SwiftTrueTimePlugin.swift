import Flutter
import UIKit
import TrueTime

public class SwiftTrueTimePlugin: NSObject, FlutterPlugin {
   public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "true_time", binaryMessenger: registrar.messenger())
    let instance = SwiftTrueTimePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let client = TrueTimeClient.sharedInstance
    switch call.method {
    case "init":
        client.start()
        result(true)
        break;
    case "now":
        client.fetchIfNeeded { time in
            switch time {
            case let .success(referenceTime):
                let millisSinceEpoch = (referenceTime.now().timeIntervalSince1970 * 1000.0).rounded()
                result(Int(millisSinceEpoch));
                break;
            case let .failure(error):
                result(FlutterError.init(code: "You must call init before any call to now",
                                         message: error.localizedDescription,
                                         details: nil));
            }
        }
     default:
         result(FlutterMethodNotImplemented);
    }
  }
}
