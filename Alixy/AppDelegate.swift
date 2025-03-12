//
//  AppDelegate.swift
//  Alixy
//
//  Created by Alixy on 2025/1/11.
//

import UIKit
import FBSDKCoreKit
import AdjustSdk
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    var window: UIWindow?

    func initAppAdjust() {
    
#if DEBUG
        let environment = ADJEnvironmentSandbox
        #else
        let environment = ADJEnvironmentProduction
#endif
        
        let adjustConfig = ADJConfig(
            appToken: "fr5i4dakvvgg",
            environment: environment)
        adjustConfig?.logLevel = ADJLogLevel.verbose
        Adjust.initSdk(adjustConfig)
        
       
    }
    
  
    //app第一次下载启动     install归因
    func trackAppInstall() {
        //钥匙串中 没有存储过该key
        let resullty = AlixyHub.shared.generateBotCreateNumber()
        
        if resullty.1 == false {
            let event = ADJEvent(eventToken: "7ljsch")
            event?.addCallbackParameter("userId", value: resullty.0)
            Adjust.trackEvent(event)
        }
        
        
    }
    
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       
        initAppAdjust()
        
        trackAppInstall()
        
        let alyNoitificationCenter = UNUserNotificationCenter.current()
        
        alyNoitificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            guard error == nil else {
                return
            }
            
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        if AlixyHub.shared.alyBotServerInfo.count == 0 {
            let alyBotPushToken = deviceToken.map { data in String(format: "%02.2hhx", data) }.joined()
            if alyBotPushToken.count > 0 && deviceToken.bytes.count > 0 {
                AlixyHub.shared.alyBotServerInfo = alyBotPushToken
            }
        }
        
    }
}

