//
//  StressReliefAccessViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/18.
//

import UIKit
import SwifterSwift

class StressReliefAccessViewController: UIViewController,UIGestureRecognizerDelegate{
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var axyAppearance:UINavigationBarAppearance?
        var titleAlyAttributes:[NSAttributedString.Key: Any]?
        
        if axyAppearance == nil && titleAlyAttributes == nil {
            
            let alyState = axyAppearance == nil && titleAlyAttributes == nil
            axyAppearance = UINavigationBarAppearance()
            axyAppearance!.configureWithTransparentBackground()
            axyAppearance!.backgroundColor = .clear
            
            titleAlyAttributes = [
                .font: UIFont.systemFont(ofSize: 17, weight: .medium), .foregroundColor: UIColor.init(hexString: "#FFFFFF") as Any]
            
            axyAppearance!.titleTextAttributes = titleAlyAttributes!
            
            navigationController?.navigationBar.standardAppearance = axyAppearance!
            navigationController?.navigationBar.scrollEdgeAppearance = axyAppearance!
            navigationController?.navigationBar.compactAppearance = axyAppearance!
            
            if navigationController?.viewControllers.count ?? 0 > 1  &&  alyState{
                let alyRouteBack = UIButton(type: .custom)
                alyRouteBack.setImage(UIImage(named: "alyRouteBack"), for: .normal)
                alyRouteBack.frame = CGRect(x: 0, y: 0, width: 40, height: 60)
                alyRouteBack.contentHorizontalAlignment = .left
                alyRouteBack.addTarget(self, action: #selector(alyRouteBackInAlixy), for: .touchUpInside)
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: alyRouteBack)
            }
        }
        
    }
    
    
    @objc func alyRouteBackInAlixy(){
        navigationController?.popViewController(animated: true)
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }

}
