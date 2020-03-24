import Flutter
import UIKit
import GameKit

public class SwiftGameCenterPlugin: NSObject, FlutterPlugin, GKGameCenterControllerDelegate {
    let viewController: UIViewController = (UIApplication.shared.delegate?.window??.rootViewController)!;
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "gamecenter", binaryMessenger: registrar.messenger())
        let instance = SwiftGameCenterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "login") {
            
            let silent = call.arguments as? Bool
            
            let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
            localPlayer.authenticateHandler = {(view, error) in
                if (error != nil) {
                    result(false)
                }
                else if (view != nil) {
                    if (silent == false) {
                        UIApplication.shared.keyWindow?.rootViewController?.present(view!, animated: true, completion: nil)
                    }
                    else {
                        if (localPlayer.isAuthenticated) {
                            result(true)
                        }
                        else {
                            result(false)
                        }
                    }
                }
                else if (localPlayer.isAuthenticated) {
                    result(true)
                }
                else {
                    result(false)
                }
            }
        }
        else if (call.method == "getPlayerName") {
            let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
            if (localPlayer.isAuthenticated) {
                result(localPlayer.alias)
            }
            else {
                result(nil)
            }
        }
        else if (call.method == "showLeaderboard") {
            let leaderboardId = call.arguments as? String
            if (GKLocalPlayer.localPlayer().isAuthenticated) {
                let gcvc = GKGameCenterViewController()
                
                gcvc.leaderboardIdentifier = leaderboardId
                gcvc.gameCenterDelegate = self
                gcvc.viewState = GKGameCenterViewControllerState.leaderboards
                
                UIApplication.shared.keyWindow?.rootViewController?.present(gcvc, animated: true, completion: nil)
                
                result(true)
            } else {
                result(false)
            }
        }
        else if (call.method == "showAchievementsBoard") {
            if (GKLocalPlayer.localPlayer().isAuthenticated) {
                let gcvc = GKGameCenterViewController()
                
                gcvc.gameCenterDelegate = self
                gcvc.viewState = GKGameCenterViewControllerState.achievements
                
                UIApplication.shared.keyWindow?.rootViewController?.present(gcvc, animated: true, completion: nil)
                
                result(true)
            } else {
                result(false)
            }
        }
        else if (call.method == "reportAchievement") {
            let arguments = call.arguments as? NSArray
            let achievementId = arguments?[0] as! String
            if (GKLocalPlayer.localPlayer().isAuthenticated) {
                let achieve = GKAchievement(identifier: achievementId)
                achieve.showsCompletionBanner = true
                achieve.percentComplete = 100.0
                
                GKAchievement.report([achieve], withCompletionHandler: {(error: Error?) -> Void in
                    if error != nil {
                        print(error!)
                        result(false)
                    } else {
                        result(true)
                    }
                })
            }
        }
        else if (call.method == "getScore") {
            let arguments = call.arguments as? NSArray
            let leaderboardId = arguments?[0] as! String
            if (GKLocalPlayer.localPlayer().isAuthenticated) {
                let leaderboard = GKLeaderboard()
                leaderboard.identifier = leaderboardId
                leaderboard.loadScores(completionHandler: {(score, error) in
                    if (error != nil) {
                        result(false)
                    }
                    result(leaderboard.localPlayerScore?.value)
                })
            }
        }
        else if (call.method == "saveScore") {
            let arguments = call.arguments as? NSArray
            let leaderboardId = arguments?[0] as! String
            let score = arguments?[1] as! Int64
            if (GKLocalPlayer.localPlayer().isAuthenticated) {
                let gkScore = GKScore(leaderboardIdentifier: leaderboardId)
                gkScore.value = score
                let scoreArray: [GKScore] = [gkScore]
                GKScore.report(scoreArray, withCompletionHandler: nil)
                
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
