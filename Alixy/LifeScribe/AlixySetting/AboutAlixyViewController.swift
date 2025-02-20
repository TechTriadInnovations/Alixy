//
//  AboutAlixyViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/25.
//

import UIKit

class AboutAlixyViewController: StressReliefAccessViewController {
    
    @IBOutlet weak var alyAppDisplayName: UILabel!
    @IBOutlet weak var alyAppVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let appAlyName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String,
           let appAlyVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            self.alyAppDisplayName.text = appAlyName
            self.alyAppVersion.text = AlixyHub.alixyInput("Veeprwsxiroan") + " " + appAlyVersion
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
