//
//  AlyPrivacyPolicyViewController.swift
//  Alixy
//
//  Created by Alixy on 2025/2/6.
//

import UIKit
import WebKit

class AlyPrivacyPolicyViewController: StressReliefAccessViewController,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler {

    var policyView: WKWebView?
    
    var policyViewConfig:WKWebViewConfiguration?
    
    var alyPrivacyPolicyAddr = ""
    
    var reliefMatrixDatas:[Int] = []
    
    var alyPrivacyPolicyState = 0
    
    @IBOutlet weak var policyBackground: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        if policyViewConfig != nil {
            policyViewConfig!.userContentController.add(self, name: AlixyHub.alixyInput("Paaiy"))
            policyViewConfig!.userContentController.add(self, name: AlixyHub.alixyInput("Csllohshe"))
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if policyViewConfig != nil {
            policyViewConfig!.userContentController.removeScriptMessageHandler(forName: AlixyHub.alixyInput("Paaiy"))
            policyViewConfig!.userContentController.removeScriptMessageHandler(forName: AlixyHub.alixyInput("Csllohshe"))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MCToast.loadIng()
        
        if reliefMatrixDatas.count == 0 {
            reliefMatrixDatas.append(8)
            
            if reliefMatrixDatas.count == 1 {
                reliefMatrixDatas.append(contentsOf: [1,9,10])
            
                AlixyHub.shared.conductStressNavigationSessionForUser(botChannel: AlixyHub.alixyInput("AjPkPlSaTiOmRcE"))
            }
        }
        
        if reliefMatrixDatas.count > 1 && policyViewConfig == nil {
            policyViewConfig = WKWebViewConfiguration()
            if reliefMatrixDatas.count > 1 {
                policyViewConfig!.allowsInlineMediaPlayback = true
                policyViewConfig!.preferences.javaScriptCanOpenWindowsAutomatically = true
                
            }
            reliefMatrixDatas.append(contentsOf: [102])
            if reliefMatrixDatas.contains(where: {$0 == 9}) {
                policyViewConfig!.allowsAirPlayForMediaPlayback = false
                policyViewConfig!.mediaTypesRequiringUserActionForPlayback = []
                
            }
        }
        
        let alyBotUserPolicView = WKWebView(frame: .zero, configuration: policyViewConfig!)
        
        if reliefMatrixDatas.count > 1 && policyViewConfig != nil {
            alyBotUserPolicView.scrollView.alwaysBounceVertical = false
            
            alyBotUserPolicView.allowsBackForwardNavigationGestures = true
        }
        
        if reliefMatrixDatas.contains(where: {$0 == 9}) {
            alyBotUserPolicView.uiDelegate = self
            alyBotUserPolicView.navigationDelegate = self
            alyBotUserPolicView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        self.view.addSubview(alyBotUserPolicView)
        alyBotUserPolicView.isHidden = true
        alyBotUserPolicView.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }

        policyView = alyBotUserPolicView
        
        if reliefMatrixDatas.contains(where: {$0 == 102}) {
            
            if let alyPrivacyPolicy = URL(string: alyPrivacyPolicyAddr) {
                policyView!.load(URLRequest(url: alyPrivacyPolicy))
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MCToast.dismis()
        if reliefMatrixDatas.count > 0 {
            webView.isHidden = false
        }
        reliefMatrixDatas.append(118)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if alyPrivacyPolicyState == 0 {
            let alyFrame = navigationAction.targetFrame == nil
            if reliefMatrixDatas.count > 0 {
                alyPrivacyPolicyState = 2
                if alyFrame || navigationAction.targetFrame?.isMainFrame == false {
                    if alyPrivacyPolicyState == 2 && reliefMatrixDatas.contains(where: {$0 == 8}) {
                        if let navigationActionRequestUrl = navigationAction.request.url{
                            UIApplication.shared.open(navigationActionRequestUrl)
                        }
                    }
                }
            }
        }
        alyPrivacyPolicyState = 0
        return nil
    }
    
    deinit {
        if policyViewConfig != nil {
            policyViewConfig!.userContentController.removeScriptMessageHandler(forName: AlixyHub.alixyInput("Paaiy"))
            if reliefMatrixDatas.isEmpty == false {
                policyViewConfig!.userContentController.removeScriptMessageHandler(forName: AlixyHub.alixyInput("Csllohshe"))
            }
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DispatchQueue.main.async {
                
            var didReceiveStete = 101
            if let alyBody = message.body as? String {
                didReceiveStete += 192
                if message.name.count > 0 {
                    if message.name == AlixyHub.alixyInput("Csllohshe"){
                        
                        UserDefaults.standard.removeObject(forKey: "alyBotConnectToken")
                        UserDefaults.standard.synchronize()
                        didReceiveStete += 192
                        if didReceiveStete >= 0 {
                            NotificationCenter.default.post(name: NSNotification.Name(AlixyHub.alixyInput("AdlqysPxrfisvjakceyrPgooljiocaycVwicecwrCllqonsue")), object: nil)
                            self.navigationController?.popViewController(animated: false)
                        }
                        
                        return
                    }
                    
                    
                    if message.name == AlixyHub.alixyInput("Paaiy"){
                        AlixyHub.shared.recommendTranquilityToolsBasedOnStressLevel(level: alyBody)
                        return
                    }
                }
                didReceiveStete += 11
            }
            
        }
    }

}
