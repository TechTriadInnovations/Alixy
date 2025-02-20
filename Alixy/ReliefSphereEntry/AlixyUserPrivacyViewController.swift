//
//  AlixyUserPrivacyViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/23.
//

import UIKit
import WebKit
import SVProgressHUD


enum AlixyUserPrivacyType {
    case userAgreement
    case privacyPolicy
    
    var fileName:String {
        switch self {
        case .userAgreement:
            return "AlixyUserAgreement"
        case .privacyPolicy:
            return "AlixyPrivacyPolicy"
        }
    }
}

class AlixyUserPrivacyViewController: StressReliefAccessViewController,WKUIDelegate,WKNavigationDelegate{
    
    var serenityHub:WKWebView?
    
    var alixyServer:String?
    
    var alixyType:AlixyUserPrivacyType = .userAgreement
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let accessBackground = UIImageView()
        accessBackground.image = UIImage(named: "accessBackground")
        self.view.addSubview(accessBackground)
        accessBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        if serenityHub == nil && serenityHubConfig == nil {
        if serenityHub == nil  {
            serenityHub = WKWebView()
            serenityHub?.navigationDelegate = self
            serenityHub?.uiDelegate = self
            
            self.view.addSubview(serenityHub!)
            updateSerenityHub()
            
            if alixyServer?.count == 0 || alixyServer == nil {
                MCToast.loadIng()
                if let filePath = Bundle.main.path(forResource: self.alixyType.fileName, ofType: "html") {
                    let fileURL = URL(fileURLWithPath: filePath)
                    
                    serenityHub!.loadFileURL(fileURL, allowingReadAccessTo: fileURL.deletingLastPathComponent())
                }
            }
        }
        
        
    }
    
    func updateSerenityHub(){
        let topSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        serenityHub!.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(topSafeAreaHeight + (self.navigationController?.navigationBar.height)!)
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MCToast.dismis()
    }
    
}
