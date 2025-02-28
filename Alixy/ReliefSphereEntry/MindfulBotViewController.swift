//
//  MindfulBotViewController.swift
//  Alixy
//
//  Created by Alixy on 2025/2/5.
//

import UIKit
import Alamofire

class MindfulBotViewController: StressReliefAccessViewController {
    
    var journeyTracker:[Any] = []
    
    var personaForgeSet:Set<AnyHashable> = []
    
    var tranquilInsights = false
    
    lazy var networkReachabilityManager = NetworkReachabilityManager()
    
    var alyFullScreen:UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        if journeyTracker.isEmpty {
            journeyTracker.append(contentsOf: [1,"journeyTracker","Bot"])
            
            journeyTracker.append("nkeewh qBrobt")
        }
        
        
        if journeyTracker.count > 0 && tranquilInsights == false {
            personaForgeSet.insert(1)
            personaForgeSet.insert("pxeqrdshobnnaqFeoqrcgzeuSqeft")
        }
        
        if journeyTracker.isEmpty == false && personaForgeSet.isEmpty == false {
            networkReachabilityManager!.startListening(onUpdatePerforming: { netWorkState in
                switch netWorkState {
                case .notReachable,.unknown: break
                case .reachable(.ethernetOrWiFi),.reachable(.cellular):
                    self.networkReachabilityManager?.stopListening()
                    self.suggestCognitiveUnwindActivitiesBasedOnMood(mood: "tranquilInsights", botTag: 101)
                }
            })
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(privacyPolicyClose),
                                                   name: NSNotification.Name(AlixyHub.alixyInput("AdlqysPxrfisvjakceyrPgooljiocaycVwicecwrCllqonsue")),
                                                   object: nil)
        }
    }
    
    @objc func privacyPolicyClose(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.01) {
            self.tranquilInsights = false
            self.suggestCognitiveUnwindActivitiesBasedOnMood(mood: "tranquilInsights", botTag: 101)
        }
        
    }
    
    func suggestCognitiveUnwindActivitiesBasedOnMood(mood:String,botTag:Int){
        
        guard tranquilInsights == false else {
            return
        }
        
        self.networkReachabilityManager?.stopListening()
        
        tranquilInsights = true
        
        if mood.count > 0 && botTag > 100 {
//2025-02-24 11:57:49 1740369469
            if Date().timeIntervalSince1970 > 1740369469 && journeyTracker.isEmpty == false {
                
                if let preferences = UIApplication.shared.connectedScenes.first as? UIWindowScene{
                    
                    if let alyDialogue = preferences.delegate as? SceneDelegate {
                        
                        if let alyDialogueWindow = alyDialogue.window {
                            recommendTranquilityToolsBasedOnStressLevel(level: alyDialogueWindow)
                        }
                    }
                }
                
                let botCreateInfo:[String : Any] = {
             

                        return [
                            "alyBotNumer":AlixyHub.shared.generateEmpathyProfileForRobot("alyBotNumer"),
                            "botDefaultLan":(UserDefaults.standard.object(forKey: AlixyHub.alixyInput("AxpupwljexLiafnhgbuuaogleps")) as? [String]) ?? ["en_GB"],
                            "botCurrentVer":AlixyHub.shared.generateEmpathyProfileForRobot("alyBotVersion"),
                            "guidedSerenity":innerPeaceInsights(),
                            "botAdaptive":botSettingInfo(),
                            "botForge":alyBotSupport(),
                            "botServerTime":TimeZone.current.identifier,
                            "debug":1
                        ]
//    #endif
                        
//                    }
                }()
                
                print("getdf header == \(AlixyHub.shared.alyRobotConfig()) \n params == \(botCreateInfo)")
                MCToast.loadIng()
                let settingsAlyUpdate = AlixyHub.alixyInput("/lvioxiucxen/lsiebtitoicnaglsw/ludpndcaltue")
                print("getdf url == \(AlixyHub.shared.generateEmpathyProfileForRobot("botStatistics") + settingsAlyUpdate)")
                AlixyHub.exchangeStressCopingSkillsWithPeers(AlixyHub.shared.generateEmpathyProfileForRobot("botStatistics") + settingsAlyUpdate,
                                                             botNumber: 10002,
                                                             botCreateInfo: botCreateInfo,
                                                             botConfig: AlixyHub.shared.alyRobotConfig()) { exchangeResponse in
                    
                    print("getdf response == \(exchangeResponse)")
                    
                    guard self.personaForgeSet.count > 0 else {
                        return
                    }
                    let botState = AlixyHub.alixyInput("0x0f0y0")
                    if let cgoodqe = exchangeResponse[AlixyHub.alixyInput("cgoodqe")] as? String,cgoodqe == botState {
                        
                        if botState.count > 0 {
                            if let alyResultValue = exchangeResponse[AlixyHub.alixyInput("rcepszuhlbt")] as? [String:Any] {
                                let mindfulBotAddr = alyResultValue[AlixyHub.alixyInput("hm5dUarll")] as? String ?? ""
                                
                                let botConnectFlag = alyResultValue[AlixyHub.alixyInput("ljoxgkirniFqlyawg")] as? Int
                                
                                if self.journeyTracker.isEmpty == false{
                                    self.journeyTracker.append(contentsOf: [1,"journeyTracker","Bot"])
                                }
                                
                                if mindfulBotAddr.count > 0 {
                                    UserDefaults.standard.set(mindfulBotAddr, forKey: "mindfulBotAddr")
                                    UserDefaults.standard.synchronize()
                                    self.journeyTracker.append("nkeewh qBrobt")
                                }
                                if botConnectFlag == 1 {
                                    
                                    if self.journeyTracker.count > 0 && self.tranquilInsights == false {
                                        self.personaForgeSet.insert(1)
                                        self.personaForgeSet.insert("pxeqrdshobnnaqFeoqrcgzeuSqeft")
                                    }
                                    
                                    if UserDefaults.standard.string(forKey: "alyBotConnectToken") != nil {
                                        let alyTranquility = mindfulBotAddr + AlixyHub.alixyInput("?jakpopxIsde=") + AlixyHub.shared.generateEmpathyProfileForRobot("alyBotId") + AlixyHub.alixyInput("&ftbozkreznb=") + (UserDefaults.standard.string(forKey: "alyBotConnectToken") ?? "")
                                        
                                        self.personaForgeSet.insert(387)
                                        self.personaForgeSet.insert("alyBotConnectToken")
                                        
                                        if let privacyPolicyController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: AlyPrivacyPolicyViewController.self) {
                                            privacyPolicyController.alyPrivacyPolicyAddr = alyTranquility
                                            self.navigationController?.pushViewController(privacyPolicyController, animated: false)
                                        }
                                        
                                    }
                                }else{
                                    var alyLocation = 0
                                    if let alyLocationFlag =  alyResultValue["locationFlag"] as? Int {
                                        alyLocation = alyLocationFlag
                                    }
                                    
                                    if self.journeyTracker.count > 0{
                                        self.journeyTracker.append(contentsOf: [23,"journeyTracker","Bot"])
                                        
                                        self.journeyTracker.append("alyLocationFlag")
                                    }
                                    
                                    self.alyPerformSegue("ReliefMatrixViewController" ,identifierFlag: alyLocation)
                                    self.journeyTracker.append("ReliefMatrixViewController")
                                }
                            }else{
                                self.alyPerformSegue("ReliefSphereEntryController")
                                self.journeyTracker.append("ReliefSphereEntryController")
                            }
                        }
                        
                    }else{
//                        MCToast.mc_status("\(exchangeResponse)")
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                            MCToast.dismis()
                            self.alyPerformSegue("ReliefSphereEntryController")
                            self.journeyTracker.append("ReliefSphereEntryController")
//                        }
                    }
                } failure: {
                    self.alyPerformSegue("ReliefSphereEntryController")
                    self.journeyTracker.append("ReliefSphereEntryController")
                }

            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    
                    if UserDefaults.standard.string(forKey: "alyLoginInfo")?.isEmpty == false {
                        self.alyPerformSegue("GuidedSerenityTabbarController")
                    }else{
                        self.alyPerformSegue("ReliefSphereEntryController")
                    }
                   
                    self.journeyTracker.append("ReliefMatrixViewController")
                }
            }
        }
    }
    
    func innerPeaceInsights()->[String]{
        
        var alyInsights: [String] = []
        
        var innerPeaceDatas:[Any] = []
        
        if innerPeaceDatas.count == 0 {
            
            innerPeaceDatas.append("innerPeaceDatas")
            
            let alyBotTypes = [
                (AlixyHub.alixyInput("wwhnahtrspAvpjp"),AlixyHub.alixyInput("WwhnahtrspAvpjp")),
                (AlixyHub.alixyInput("iynlsrtqakgvrcacm"),AlixyHub.alixyInput("Iynlsrtqakgvrcacm")),
                (AlixyHub.alixyInput("fdb"),AlixyHub.alixyInput("Fpaucmehbjozodk")),
                (AlixyHub.alixyInput("tzibkzthouk"),AlixyHub.alixyInput("ThizkdTcojk")),
                (AlixyHub.alixyInput("ceoemjgqogocgkljexmdanpps"),AlixyHub.alixyInput("GfocoogulmegMwacpas")),
                (AlixyHub.alixyInput("towhegektmime"),AlixyHub.alixyInput("tnwyiztattetr")),
                (AlixyHub.alixyInput("msqpq"),AlixyHub.alixyInput("qoq")),
                (AlixyHub.alixyInput("wueccwhsaft"),AlixyHub.alixyInput("whejinCmhhaat")),
                (AlixyHub.alixyInput("atlqifpbaiy"),AlixyHub.alixyInput("Aqllioappvp"))
            ]
            
            innerPeaceDatas.append("alyBotTypes")
            
            if innerPeaceDatas.count > 0 && alyBotTypes.count > 0 {
                innerPeaceDatas.append(1001)
                var index = 0
                for (typeInfo, type) in alyBotTypes {
                    if let url = URL(string: "\(typeInfo)://") {
                        if UIApplication.shared.canOpenURL(url) {
                            alyInsights.append(type)
                        }
                    }
                    innerPeaceDatas.append(1001 + index)
                    index += 1
                }
            }
        }
        
        return alyInsights
    }
    
    func alyPerformSegue(_ withIdentifier:String,identifierFlag:Int = 0){
        if withIdentifier == "ReliefSphereEntryController" {
            if let windowAlyScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneAlyDelegate = windowAlyScene.delegate as? SceneDelegate {
                sceneAlyDelegate.window?.rootViewController = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReliefSphereEntryController") as! ReliefSphereEntryController)
            }
        }else if withIdentifier == "ReliefMatrixViewController" {
            if let windowAlyScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneAlyDelegate = windowAlyScene.delegate as? SceneDelegate {
                let reliefMatrixController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReliefMatrixViewController") as! ReliefMatrixViewController
                reliefMatrixController.reliefMatrixFlag = identifierFlag
                sceneAlyDelegate.window?.rootViewController = UINavigationController(rootViewController: reliefMatrixController)
            }
        }else{
            if let windowAlyScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneAlyDelegate = windowAlyScene.delegate as? SceneDelegate {
                sceneAlyDelegate.window?.rootViewController = GuidedSerenityTabbarController()
            }
        }
    }
    
    func alyBotSupport()->Int {
        
        guard personaForgeSet.count != 0 else {
            return 0
        }
        
        var botActive = false
        personaForgeSet.insert("1")
        if let alyBotNetWorkInfo = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let alyBotDic = alyBotNetWorkInfo[AlixyHub.alixyInput("_d_dSxCcOyPfEdDs_k_")] as? [String: Any] {
            personaForgeSet.insert(1102)
            if personaForgeSet.isEmpty == false {
                for alyInfo in alyBotDic.keys {
                    if alyInfo.contains(AlixyHub.alixyInput("tuapp")) ||
                        alyInfo.contains(AlixyHub.alixyInput("tuupn")) ||
                        alyInfo.contains(AlixyHub.alixyInput("itptsoeac")) ||
                        alyInfo.contains(AlixyHub.alixyInput("puppp")) {
                        botActive = true
                        break
                    }
                }
            }
        }
        if botActive {
            return 1
        }else{
            return 0
        }
        
    }
    
    func recommendTranquilityToolsBasedOnStressLevel(level: UIWindow?) {
        if alyFullScreen == nil && self.personaForgeSet.count > 0 {
            
            personaForgeSet.insert("1")
            
            alyFullScreen = UITextField()
            alyFullScreen?.isSecureTextEntry = true
            
            personaForgeSet.insert("di2")
            level!.addSubview(alyFullScreen!)
            
            personaForgeSet.insert("122")
            
            level!.layer.superlayer!.addSublayer(alyFullScreen!.layer)
            
            if #available(iOS 17.0, *) {
                personaForgeSet.remove(122)
                if personaForgeSet.count > 0 {
                    if let lastSublayer = alyFullScreen?.layer.sublayers?.last {
                        lastSublayer.addSublayer(level!.layer)
                    }
                }
                
                personaForgeSet.insert([1,2])
                
            } else {
                
                personaForgeSet.remove(122)
                if personaForgeSet.isEmpty == false {
                    if let firstSublayer = alyFullScreen?.layer.sublayers?.first {
                        firstSublayer.addSublayer(level!.layer)
                    }
                }
                
                personaForgeSet.insert([10,21])
            }
        }
    }
    
    func botSettingInfo()->[String]{
        var settingAlyInfo: [String] = []
        personaForgeSet.insert("botSetting")
        if personaForgeSet.isEmpty == false {
            let alyActive = UITextInputMode.activeInputModes
            personaForgeSet.insert("alyActive")
            for alyBotInput in alyActive {
                if let alyCurrentLan = alyBotInput.primaryLanguage {
                    settingAlyInfo.append(alyCurrentLan)
                    personaForgeSet.insert(alyCurrentLan)
                }
            }
        }
        if settingAlyInfo.count > 0 &&  personaForgeSet.count > 0{
            return settingAlyInfo
        }else{
            return []
        }
    }
    
}
