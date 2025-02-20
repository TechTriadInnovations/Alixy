//
//  AlixySettingTableViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/25.
//

import UIKit
import SwifterSwift

class AlixySettingTableViewController: UITableViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var botOrbs: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let backgroundImage = UIImageView(image: UIImage.journeyTrackerBackground)
        backgroundImage.frame = self.tableView.bounds
        self.tableView.backgroundView = backgroundImage
        self.title = AlixyHub.alixyInput("Syectrtpicnyg")
        
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
            
            let alyRouteBack = UIButton(type: .custom)
            alyRouteBack.setImage(UIImage(named: "alyRouteBack"), for: .normal)
            alyRouteBack.frame = CGRect(x: 0, y: 0, width: 40, height: 60)
            alyRouteBack.contentHorizontalAlignment = .left
            alyRouteBack.addTarget(self, action: #selector(alyRouteBackInAlixy), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: alyRouteBack)
        }
        
        AlixyHub.shared.alixyRoverBot
            .compactMap{$0}
            .subscribe(onNext: { alixyRoverBot in
                self.botOrbs.text = "\(alixyRoverBot.botOrbs)"
            })
            .disposed(by: rx.disposeBag)
    }
    
    @objc func alyRouteBackInAlixy(){
        navigationController?.popViewController(animated: true)
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBAction func deleteAccountInAlixy(_ sender: UIButton) {
        clearAlyCache(alyState: 0)
    }
    
    @IBAction func logoutInAlixy(_ sender: UIButton) {
        clearAlyCache(alyState: 1)
    }
    
    func clearAlyCache(alyState:Int){
        var alyAlertMessage = ""
        if alyState == 0 {
            alyAlertMessage = AlixyHub.alixyInput("Ahfptyeyrl ytvhgeb gascrcbobuznftv liask mdcejleewtfecdj,v ptahied sdhaqtkam ocjafntnroltg sbfef crfewctofvqeurheldx.q sAdrqem dyookul esfuardew ayaoiuw owvaenytz vtzoz odredlxestveu liitq?")
        }else{
            alyAlertMessage = AlixyHub.alixyInput("Afrved zyxovux zscumrbel ryooxuc gwpadnqtu ftiow iljorgh aopunti?")
        }
        
        self.showAlert(title: nil, message: alyAlertMessage,buttonTitles: [AlixyHub.alixyInput("Cqainuckell"),AlixyHub.alixyInput("Syudrle")]) { completionAlyIndex in
            if completionAlyIndex == 1 {
                AlixyHub.shared.trackStressReliefProgressForUser(userID: "alyState", alyState: alyState)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 1,2:
            let alixyUserPrivacyViewController = AlixyUserPrivacyViewController()
            if indexPath.section == 2 {
                alixyUserPrivacyViewController.alixyType = .userAgreement
            }else{
                alixyUserPrivacyViewController.alixyType = .privacyPolicy
            }
            navigationController?.pushViewController(alixyUserPrivacyViewController)
            
        case 0:
            let alixyBotOrdsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: AlixyBotOrdsViewController.self)
            self.navigationController?.pushViewController(alixyBotOrdsController!)
            
        case 3:
            
            let moodTrackerController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: MoodTrackerViewController.self)
            
            self.navigationController?.pushViewController(moodTrackerController!)
        case 4:
            
            let aboutAlixyController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: AboutAlixyViewController.self)
            
            self.navigationController?.pushViewController(aboutAlixyController!)
        case 5:
            let alixyBlockUser = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: AlixyBlockUserViewController.self)
            
            self.navigationController?.pushViewController(alixyBlockUser!)
        default:
            break
            
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


class AlixyBlockUserViewController : StressReliefAccessViewController {
    
}
