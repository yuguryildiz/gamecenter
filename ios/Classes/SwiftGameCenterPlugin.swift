import Flutter
import UIKit
import GameKit

public class SwiftGameCenterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "gamecenter", binaryMessenger: registrar.messenger())
    let instance = SwiftGameCenterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "connect") {
        let player: GKLocalPlayer = GKLocalPlayer.localPlayer()
        player.authenticateHandler = {(view, error) in
            if (error == nil) {
                result(player)
            }
            result(error)
        }
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
}
