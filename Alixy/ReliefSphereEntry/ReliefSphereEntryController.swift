//
//  ReliefSphereEntryController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/18.
//

import UIKit
import SwifterSwift
import SVProgressHUD

class ReliefSphereEntryController: StressReliefAccessViewController,UITextViewDelegate {

    @IBOutlet weak var alixyHandTextView: UITextView!
    @IBOutlet weak var boxCheckButton: UIButton!
    
    @IBOutlet weak var alyAccount: UITextField!
    @IBOutlet weak var alyLoginPassword: UITextField!
    
    var boxAlixyState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initAlixyViews()
        
        
//#if DEBUG
//        self.alyAccount.insertText("alixy@gmail.com")
//        self.alyLoginPassword.insertText("666666")
//        self.boxCheckButton.isSelected = true
//#endif
    }
    
    
    func initAlixyViews(){
        let alixyFull = AlixyHub.alixyInput("Asgnrxemei itpoh dtghrey wUjsbeirc eAcgirfewefmdewnitj vawnodi ePqrvitvzayctyp bAtgzrieoermdesnft")
        let alixyuser = AlixyHub.alixyInput("Upsoerrz zAhghrheaegmnennnt")
        let alixyPrivacy = AlixyHub.alixyInput("Pkrnipvdajckyv cAqgwrjekecmvecnpt")
        let alixyPrivacyCount = alixyPrivacy.count
        
        if alixyFull.count > 0 && alixyuser.count > 0 && alixyPrivacyCount > 0 {
            if let alixyRangeUser = alixyFull.range(of: alixyuser),let alixyPrange = alixyFull.range(of: alixyPrivacy) ,alixyFull.count > 0 && alixyPrivacyCount != 0 {
                
                if alixyuser.count != 0 && alixyPrivacyCount + alixyFull.count != 0 {
                    let alixyUserCover = NSRange(alixyRangeUser,in: alixyFull)
                    let alixyPrivacyConver = NSRange(alixyPrange,in: alixyFull)
                    
                    let fullAttributedString = NSMutableAttributedString(string: alixyFull)
                    if fullAttributedString.string.count > 0 {
                        fullAttributedString.addAttribute(.foregroundColor, value:UIColor.white, range: NSMakeRange(0, alixyFull.count))
                        if fullAttributedString.string.count > alixyPrivacyCount {
                            fullAttributedString.addAttribute(.link, value: "alixyTypeU://", range: alixyUserCover)
                            fullAttributedString.addAttribute(.link, value: "alixyTypeP://", range: alixyPrivacyConver)
                            if fullAttributedString.string.count > 0 {
                                let paragraphStyle = NSMutableParagraphStyle()
                                paragraphStyle.alignment = .center
                                fullAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, alixyFull.count))
                                
                                alixyHandTextView.delegate = self
                                alixyHandTextView.linkTextAttributes = [.foregroundColor:UIColor.init(hexString: "#D9FD39") as Any]
                                alixyHandTextView.attributedText = fullAttributedString
                                alixyHandTextView.dataDetectorTypes = .link
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func boxChangeInAlixy(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        boxAlixyState = sender.isSelected ? 1 : 0
    }
    
    @IBAction func loginAlixy(_ sender: UIButton) {
        if self.alyAccount.text?.isEmpty == true {
            MCToast.mc_text(AlixyHub.alixyInput("Pzluenasswee yeynhtzehrf ayzoaujrb pewmnazipl"))
            return
        }
        
        if self.alyLoginPassword.text?.isEmpty == true {
            MCToast.mc_text(AlixyHub.alixyInput("Pilieeadslep cegnxtmesrl uyloduerd vpzarsdsuwtogrfd"))
            return
        }
        
        if boxCheckButton.isSelected == false {
            MCToast.mc_text(AlixyHub.alixyInput("Pslteiamsieb srneeaada majnjdf nangtrxekea wtyoq ptchmer kUjsuegro iAwgprberecmmecngtv fagnpds fPxrhicvjawcyyo iArgcrzeiejmgeznqt"))
            return
        }
        
        MCToast.loadIng()
        _ = AlixyHub.shared
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let alyAccount = self.alyAccount.text,let alyPassword = self.alyLoginPassword.text {
                if alyAccount == "alixy@gmail.com" && alyPassword == "666666" {
                    AlixyHub.shared.syncPersonalityAttributesToCloud()
                    UserDefaults.standard.set("alyLoginInfo", forKey: "alyLoginInfo")
                    UserDefaults.standard.synchronize()
                    if let windowAlyScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let sceneAlyDelegate = windowAlyScene.delegate as? SceneDelegate {
                        sceneAlyDelegate.window?.rootViewController = GuidedSerenityTabbarController()
                    }
                    MCToast.dismis()
                }else{
                    MCToast.mc_text(AlixyHub.alixyInput("Pelvekabsieu mcmhgencjki myoolufrz yuhstesranravmpeu zapnedl qpcaysxscwdohrkd"))
                }
            }
        }
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        let textViewUrlScheme = URL.scheme
        if textViewUrlScheme?.isEmpty == false {
            if let alixyScheme = textViewUrlScheme {
                let alixyUserPrivacyViewController = AlixyUserPrivacyViewController()
                if alixyScheme == "alixyTypeU" {
                    alixyUserPrivacyViewController.alixyType = .userAgreement
                }else{
                    alixyUserPrivacyViewController.alixyType = .privacyPolicy
                }
                navigationController?.pushViewController(alixyUserPrivacyViewController)
            }
            
        }
        
        return false
    }
    
}

