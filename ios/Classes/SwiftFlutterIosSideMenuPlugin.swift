import Flutter
import UIKit

public class SwiftFlutterIosSideMenuPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "side_menu_scaffold", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterIosSideMenuPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
