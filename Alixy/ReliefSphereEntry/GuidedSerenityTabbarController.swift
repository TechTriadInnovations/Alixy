//
//  GuidedSerenityTabbarController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/18.
//

import UIKit

class GuidedSerenityTabbarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAlixyTabbars()
    }
    
    func initAlixyTabbars(){
        self.delegate = self
        
        self.tabBar.backgroundColor = UIColor.init(hexString: "#D9FD39")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let journeyController = storyboard.instantiateViewController(withIdentifier: "JourneyTrackerViewController") as! JourneyTrackerViewController
        let navToJourneyController = UINavigationController(rootViewController: journeyController)
        navToJourneyController.title = AlixyHub.alixyInput("CvOxMdMfUcNjIfTfY")
        navToJourneyController.tabBarItem.image = UIImage(named: "tabbarTracker")?.withRenderingMode(.alwaysOriginal)
        navToJourneyController.tabBarItem.selectedImage = UIImage(named: "tabbarTrackers")?.withRenderingMode(.alwaysOriginal)
        self.addChild(navToJourneyController)
        
        let personaController = storyboard.instantiateViewController(withIdentifier: "InteractiveHavenViewController") as! InteractiveHavenViewController
        let navToPersonaController = UINavigationController(rootViewController: personaController)
        navToPersonaController.title = AlixyHub.alixyInput("HdOkMeE")
        navToPersonaController.tabBarItem.image = UIImage(named: "tabbarForge")?.withRenderingMode(.alwaysOriginal)
        navToPersonaController.tabBarItem.selectedImage = UIImage(named: "tabbarForges")?.withRenderingMode(.alwaysOriginal)
        self.addChild(navToPersonaController)
        
        let lifeController = storyboard.instantiateViewController(withIdentifier: "LifeScribeViewController") as! LifeScribeViewController
        let navToLifeController = UINavigationController(rootViewController: lifeController)
        navToLifeController.title = AlixyHub.alixyInput("MfIrNxE")
        navToLifeController.tabBarItem.image = UIImage(named: "tabbarLife")?.withRenderingMode(.alwaysOriginal)
        navToLifeController.tabBarItem.selectedImage = UIImage(named: "tabbarLifes")?.withRenderingMode(.alwaysOriginal)
        self.addChild(navToLifeController)
        
        self.selectedIndex = 1
        
        self.tabBar.tintColor = UIColor(hexString: "#354604") // 选中颜色
        self.tabBar.unselectedItemTintColor = UIColor(hexString: "#354604",transparency: 0.7) // 未选中颜色
    }
    

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        alixySetAnimationsEnabled(enable: false)
        return true
    }
    
    func alixySetAnimationsEnabled(enable:Bool){
        UIView.setAnimationsEnabled(enable)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        alixySetAnimationsEnabled(enable: true)
        
        guard let tabBarItems = tabBar.items,
              let itemIndex = tabBarItems.firstIndex(of: viewController.tabBarItem) else {
            return
        }
        
        let indexTabbarItem = tabBar.subviews[itemIndex + 1]
        addBounceAnimation(to: indexTabbarItem)
    }
        
    func addBounceAnimation(to view: UIView) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.2, 0.9, 1.0]
        bounceAnimation.keyTimes = [0, 0.3, 0.6, 1.0]
        bounceAnimation.duration = 0.4
        view.layer.add(bounceAnimation, forKey: "bounce")
    }

}
