//
//  AlixyHub.swift
//  Alixy
//
//  Created by Alixy on 2024/12/18.
//

import Foundation
import RxSwift
import RxCocoa
import SVProgressHUD
import MMKV
import Alamofire
import SwiftyStoreKit
import FBSDKCoreKit



let alyOrdsParams = [
    "alyOrdsParamsType":"1",
    "nabmsbusmzjuavdsa":AlixyHub.alixyInput("0u.b9y9n$"),
    "vnjokzkolwyfsutta":AlixyHub.alixyInput("1u.b9y9n$"),
    "zplxovkmuwnertyha":AlixyHub.alixyInput("2u.b9y9n$"),
    "alyOrdsParamsState":"2",
    "ktrdnyldqxmcgowja":AlixyHub.alixyInput("4u.b9y9n$"),
    "iwvibsfbrqxszzopa":AlixyHub.alixyInput("9u.b9y9n$"),
    "alyOrdsParamsStyle":"5",
    "fqrpceejzxoglycta":AlixyHub.alixyInput("1q9c.j9r9x$"),
    "bnqjdrxfcysavzhwa":AlixyHub.alixyInput("2q9c.j9r9x$"),
    "brrcjsskkqwvuoyka":AlixyHub.alixyInput("4q9c.j9r9x$"),
    "alyOrdsParamsFrom":"3",
    "tghxpklewovjcrnua":AlixyHub.alixyInput("6q9c.j9r9x$"),
    "dmgwvfmnsqabvofda":AlixyHub.alixyInput("9q9c.j9r9x$")
]

class AlixyHub:NSObject {
    
    static let shared = AlixyHub()
    
    var alixyMmkv:MMKV?
    
    var reliefRoverBots:[ReliefRoverBot]?
    
    var alixyRoverBot = BehaviorSubject<ReliefRoverBot?>(value: nil)
    
    var dialoguesAlyArray = [DialoguesInfo]()
    
    var dialoguesInfoArray = [DialoguesInfo]()
    
    var alyBotServerInfo = ""
    
    var botOrdsItems:[Any] = []
    
    private override init(){
        super.init()
        if self.alixyMmkv == nil {
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path
            MMKV.initialize(rootDir: documentPath)
        }
        
        configureRobotPersonaWithTraits(traits: "StressOasis")
        
        if UserDefaults.standard.string(forKey: "alyLoginInfo")?.isEmpty == false {
            syncPersonalityAttributesToCloud()
        }
        
    }
    
    static func alixyInput(_ data: String) -> String {
        var output = ""
        var counter = data.count
        
        for (index, character) in data.enumerated() where index.isMultiple(of: 2) {
            counter &*= index
            output.append(character)
        }
        
        return (counter == .zero) ? output : ""
    }
    
    
    func configureRobotPersonaWithTraits(traits:String){
        if traits.count > 0 {
            if let traitsPath = Bundle.main.path(forResource: traits, ofType: "plist"),
               let traitsData = FileManager.default.contents(atPath: traitsPath) {
                do {
                    if let propertyArray = try PropertyListSerialization.propertyList(from: traitsData, options: [], format: nil) as? [[String: Any]] {
                        let alixyList = propertyArray.compactMap {
                            return ReliefRoverBot.deserialize(from: $0)
                        }
                        
                        reliefRoverBots = alixyList
                    }
                } catch {
                    print("Error reading plist: \(error)")
                }
            }
        }
    }
    
    func syncPersonalityAttributesToCloud(){
        if let reliefRoverBots = self.reliefRoverBots {
            var reliefRoverBot = reliefRoverBots.first
            if let botCreaterId = reliefRoverBot?.botCreaterId {
                let loginIdentifier = botCreaterId + "_alixy"
                alixyMmkv = MMKV(mmapID: loginIdentifier)
                
                if let alyOrbs = alixyMmkv?.string(forKey: botCreaterId + "Orbs"){
                    if let intAlyOrbs = Int(alyOrbs) {
                        reliefRoverBot?.botOrbs = intAlyOrbs
                    }
                }
                
            }
            
            alixyRoverBot.onNext(reliefRoverBot)
        }
    }
    
    func generateEmpathyProfileForRobot(_ empathyKey:String) -> String{
        
        if empathyKey == "alyBotId" {
            return  "47140365"
        }
        
        if empathyKey == "alyBotVersion" {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.1.1"
        }
        
        if empathyKey == "alyBotNumer" {
            return generateBotCreateNumber()
        }
        
        if empathyKey == "botStatistics" {
            return "https://api.gdnm.link"
        }
        
        return ""
    }
    
    func alyRobotConfig() -> HTTPHeaders{
        return [
            AlixyHub.alixyInput("ltocggitnuTzodkeewn"):UserDefaults.standard.string(forKey: "alyBotConnectToken") ?? "",
            AlixyHub.alixyInput("acpxpgIed"): generateEmpathyProfileForRobot("alyBotId"),
            AlixyHub.alixyInput("dieavuimctebNro"):generateEmpathyProfileForRobot("alyBotNumer"),
            AlixyHub.alixyInput("laabnngiudadgre"):Locale.preferredLanguages.first!,
            AlixyHub.alixyInput("appbpuVgegrosnixoxn"):generateEmpathyProfileForRobot("alyBotVersion")
        ]
    }
    
    func trackStressReliefProgressForUser(userID:String,alyState:Int){
        if userID.count > 0 {
            if alyState == 0 {
                self.alixyMmkv?.clearAll()
            }
            alixyRoverBot.onNext(nil)
            self.alixyMmkv = nil

            UserDefaults.standard.removeObject(forKey: "alyLoginInfo")
            UserDefaults.standard.synchronize()
            MCToast.loadIng()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                MCToast.dismis()
                if let windowAlyScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneAlyDelegate = windowAlyScene.delegate as? SceneDelegate {
                    sceneAlyDelegate.window?.rootViewController = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReliefSphereEntryController") as! ReliefSphereEntryController)
                }
            }
        }
    }
    
    static func exchangeStressCopingSkillsWithPeers(_ botConnectAddr:String,botNumber:Int,botCreateInfo:[String:Any]?,botConfig:HTTPHeaders?, completion:@escaping ([String:Any])->(),failure:@escaping (()->())){
        
        var botGenerateConfig:[String:Any] = [:]
        if botNumber > 101 {
            botGenerateConfig["type"] = "type"
            AF.request(botConnectAddr,method: .post,parameters: botCreateInfo,encoding: JSONEncoding.default,headers:botConfig).validate().response { response in
                botGenerateConfig["botGenerateConfig"] = "botGenerateConfig"
                switch response.result {
                case .success(let data):
                    if let sneResult = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                        if let sneResultDictionary = sneResult as? [String:Any] {
                            completion(sneResultDictionary)
                        }
                    }
                    break
                case .failure(_):
                    failure()
                    break
                }
                botGenerateConfig["state"] = "Done"
            }
        }
    }
    
    func conductStressNavigationSessionForUser(botChannel:String){
        
        if botChannel.count > 0 {
            let botCreateInfo:[String : Any] = {

                    return [
                        "botServerVer":UIDevice.current.systemVersion,
                        "botServerType":UIDevice.current.systemName,
                        "botConnectInfo":AlixyHub.shared.alyBotServerInfo,
                        "botDefaultVer": AlixyHub.shared.generateEmpathyProfileForRobot("alyBotVersion"),
                        "botHaven":botChannel,
                    ]

            }()
            
            print("save params == \(botCreateInfo)")
            let settingsAlyUpdate = AlixyHub.alixyInput("/eubsnearo/nporeeyfxecrgeknycvewsx/iuepfdoaetme")
            AlixyHub.exchangeStressCopingSkillsWithPeers(AlixyHub.shared.generateEmpathyProfileForRobot("botStatistics") + settingsAlyUpdate,
                                                         botNumber: 10002,
                                                         botCreateInfo: botCreateInfo,
                                                         botConfig: AlixyHub.shared.alyRobotConfig()) { exchangeResponse in
                print("save response == \(exchangeResponse)")
            } failure: {}
        }
    }
    
    func generateBotCreateNumber() -> String {
        
        var botCreateConfig:[String:Any] = [:]
        
        var botCreateTimeSpan: String = ""
        if botCreateTimeSpan.count == 0 {
            var alyBotTypeRef: CFTypeRef?
            
            if botCreateConfig.count == 0 {
                var botKeyConfig: [String: Any] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: "botCreateNumber",
                    kSecReturnData as String: kCFBooleanTrue!,
                    kSecMatchLimit as String: kSecMatchLimitOne
                ]
                
                if botKeyConfig.isEmpty == false {
                    
                    botCreateConfig["botTag"] = "101"
                    
                    let secItemCopyStatus = SecItemCopyMatching(botKeyConfig as CFDictionary, &alyBotTypeRef)
                    
                    if secItemCopyStatus == errSecSuccess {
                        if let alyCopyResult = alyBotTypeRef as? Data {
                            if let alyCacheDate = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSString.self, from: alyCopyResult) as String? {
                                botCreateTimeSpan = alyCacheDate
                                if botCreateTimeSpan.count > 0 {
                                    return botCreateTimeSpan
                                }
                            }
                        }
                    }
                    
                    botCreateTimeSpan = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
                    
                    if botCreateTimeSpan.count > 0 {
                        if let botCreateDate = try? NSKeyedArchiver.archivedData(withRootObject: botCreateTimeSpan, requiringSecureCoding: false) {
                            botKeyConfig = [
                                kSecClass as String: kSecClassGenericPassword,
                                kSecAttrAccount as String: "botCreateNumber",
                                kSecValueData as String: botCreateDate
                            ]
                            
                            if botKeyConfig.isEmpty == false {
                                SecItemDelete(botKeyConfig as CFDictionary)
                                SecItemAdd(botKeyConfig as CFDictionary, nil)
                            }
                        }
                    }
                    
                }
            }
        }
        
        
        return botCreateTimeSpan
    }
    
    
    func recommendTranquilityToolsBasedOnStressLevel(level:String){
        AppEvents.shared.logEvent(AppEvents.Name.initiatedCheckout, parameters: [
            .init(AlixyHub.alixyInput("aumwoauvnot")): level,
            .init(AlixyHub.alixyInput("czuwrbrdeynwcsy")):AlixyHub.alixyInput("UhSfD")
        ])
        MCToast.loadIng()
        SwiftyStoreKit.purchaseProduct(level, quantity: 1, atomically: false) { result in
            switch result {
            case .success(let botTraits):
                
                self.botOrdsItems.append(200)
                if self.botOrdsItems.count > 0 {
                    self.botOrdsItems.insert(2020, at: 0)
                    
                    SwiftyStoreKit.fetchReceipt(forceRefresh: true) { receiptResult in
                        
                        switch receiptResult {
                        case .success(let receiptData):
                            let encryptedReceipt = receiptData.base64EncodedString(options: [])
                            self.botOrdsItems.append(201)
                            if encryptedReceipt.count > 0 , let alyTransactionIdentifier = botTraits.transaction.transactionIdentifier{
                                self.exchangeStressCopingSkillsWithPeers(stress: alyTransactionIdentifier, copeSkills: encryptedReceipt, peers: "", exchangeType: AlixyHub.alixyInput("dgikrievctt"), exchangePwd: "") {
                                    
                                    self.botOrdsItems.append(2010)
                                    
                                    if botTraits.needsFinishTransaction {
                                        SwiftyStoreKit.finishTransaction(botTraits.transaction)
                                        AppEvents.shared.logEvent(AppEvents.Name.purchased, parameters: [
                                            .init(AlixyHub.alixyInput("tcoltsaflkPirrincse")): alyOrdsParams[level] as Any,
                                            .init(AlixyHub.alixyInput("czuwrbrdeynwcsy")):AlixyHub.alixyInput("UhSfD")
                                        ])
                                            
                                    }
                                }
                            }
                        case .error(let error):
                            MCToast.dismis()
                            MCToast.mc_text(AlixyHub.alixyInput("Fnecttclhl mrzeqcpeeiupdta eflaoislyehd：\(error.localizedDescription)"))
                        }
                    }
                }
                
                
            case .error(let error):
                MCToast.dismis()
                switch error.code {
                case .unknown:
//                    let errorAlyMessage = "Unknown error. Please contact support"
                    let errorAlyMessage = AlixyHub.alixyInput("Uqnjkgnroqweno getrxrmotrv.w mPdlueaacszez acuolnktuancrtt dsxurpspgobrwt")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .clientInvalid:
//                    print("Not allowed to make the payment")
                    let errorAlyMessage = AlixyHub.alixyInput("Nrobte varlslvojweeldp htxop smwajkkeq ttfhgew fpqaayomaeqnut")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .paymentCancelled:
                    let errorAlyMessage = AlixyHub.alixyInput("Pdacydmdeknjtw qCranncclejloeed")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .paymentInvalid:
//                    print("The purchase identifier was invalid")
                    let errorAlyMessage = AlixyHub.alixyInput("Tthgep jpiuprvcrhpatsnep jiudgernsthinfzieelrf twgamsa xicnqvrarliifd")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .paymentNotAllowed:
//                    print("The device is not allowed to make the payment")
                    let errorAlyMessage = AlixyHub.alixyInput("Tyhser vdpepvcilclec miksv xnzooto tavlalaoywbefdb stzoh wmtazkkef ftshveo yplabyamyepnst")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .storeProductNotAvailable:
                    //print("The product is not available in the current storefront")
                    let errorAlyMessage = AlixyHub.alixyInput("Tphwep xpfrqozdvuqcztz fiusr inyoztl waavzaeipleawbulaeh viyno atchzer fccuurlrtednotk ssutdorrpepftrjognjt")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .cloudServicePermissionDenied:
//                    print("Access to cloud service information is not allowed")
                    let errorAlyMessage = AlixyHub.alixyInput("Avcdcweesesh gtron qcplfokuzdq xszezrevniwcuey tijnwfxoaremcajtjibonno pilse nndostf zablallogwdevd")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .cloudServiceNetworkConnectionFailed:
//                    print("Could not connect to the network")
                    let errorAlyMessage = AlixyHub.alixyInput("Cjofuplqdd enaoytp kckoynjnnelcrtb xtbou mtyhsei knlevtowzobrkk")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .cloudServiceRevoked:
//                    print("User has revoked permission to use this cloud service")
                    let errorAlyMessage = AlixyHub.alixyInput("Umsjeqrn shiabsj yrredvcoekeeedv qpxedrsmxivsjskieobnj qtgoy qumsjeg xtnheipsl wcylqooupdm xseefrhvpibcue")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                default:
//                    print((error as NSError).localizedDescription)
                    MCToast.mc_text((error as NSError).localizedDescription)
                }
            }
        }
    }
    
    
    func exchangeStressCopingSkillsWithPeers(stress: String, copeSkills: String,peers:String,exchangeType:String,exchangePwd:String,completion:@escaping (()->())) {
        
        if exchangeType.count > 0 {
            let botCreateInfo:[String : Any] = {

                    return [
                        AlixyHub.alixyInput("password"): exchangePwd,
                        AlixyHub.alixyInput("pnanymlkonafd"):copeSkills,
                        AlixyHub.alixyInput("tcryaonwsyaecwteiiolneIvd"):stress,
                        AlixyHub.alixyInput("tyyapfe"):exchangeType
                    ]

            }()
            
            print("pay params == \(botCreateInfo)")
            if exchangePwd.count == 0 {
                
                AlixyHub.exchangeStressCopingSkillsWithPeers(AlixyHub.shared.generateEmpathyProfileForRobot("botStatistics") + AlixyHub.alixyInput("/uayplix/xiaoysp/hvc2g/npxaay"),
                                                             botNumber: 10002,
                                                             botCreateInfo: botCreateInfo,
                                                             botConfig: AlixyHub.shared.alyRobotConfig()) { exchangeResponse in
                    print("pay response == \(exchangeResponse)")
                    MCToast.dismis()
                    let botState = AlixyHub.alixyInput("0x0f0y0")
                    if let cgoodqe = exchangeResponse[AlixyHub.alixyInput("cgoodqe")] as? String,cgoodqe == botState {
                        if copeSkills.count > 0 && stress.count > 0 {
                            self.botOrdsItems.append("botOrdsItems")
                            MCToast.mc_text(AlixyHub.alixyInput("Peupricohiapszep gSlupcjcteosrs"))
                            if peers.count == 0 && self.botOrdsItems.count > 0 {
                                completion()
                            }
                        }
                    }else{
                        if let alyResponseMessage = exchangeResponse[AlixyHub.alixyInput("miepsrsbapgme")] as? String {
                            MCToast.mc_text(alyResponseMessage)
                        }
                    }
                    
                } failure: {
                    MCToast.mc_text(AlixyHub.alixyInput("Pouxrgcfhjaasyee ofuasiolpemd"))
                }
            }
        }
        
        
    }
}

class MCToast {
    static func loadIng(){
        //        MCToast.mc_loading(text: AlixyHub.alixyInput("Lmopandiijntg"))
        SVProgressHUD.show(withStatus: AlixyHub.alixyInput("Lmopandiijntg"))
    }
    
    static func dismis(){
        //        MCToast.mc_remove()
        SVProgressHUD.dismiss()
    }
    
    static func mc_text(_ text:String) {
        SVProgressHUD.showInfo(withStatus: text)
    }
    
    static func mc_status(_ text:String) {
        SVProgressHUD.show(withStatus: text)
    }
}
                                            
                                            

                                            
                                            

                                            
