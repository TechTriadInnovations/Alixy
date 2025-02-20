//
//  SceneDelegate.swift
//  Alixy
//
//  Created by Alixy on 2025/1/11.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyStoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let atomically = true
        if atomically {
            SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
                for purchase in purchases {
                    switch purchase.transaction.transactionState {
                    case .purchased, .restored:
                        if purchase.needsFinishTransaction {
                            SwiftyStoreKit.finishTransaction(purchase.transaction)
                        }
                    case .failed, .purchasing, .deferred:break
                    @unknown default:break
                    }
                }
            }
        }
        
        configAlixyIQKeyboardManager()
        
        window?.rootViewController = UINavigationController(rootViewController:UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MindfulBotViewController") as! MindfulBotViewController)
        
//        if UserDefaults.standard.string(forKey: "alyLoginInfo")?.isEmpty == false {
//            window?.rootViewController = GuidedSerenityTabbarController()
//        }else{
//            window?.rootViewController = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReliefSphereEntryController") as! ReliefSphereEntryController)
//        }
        
        window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func configAlixyIQKeyboardManager(){
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
    }


}
