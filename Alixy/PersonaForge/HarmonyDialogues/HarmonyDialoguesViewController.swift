//
//  HarmonyDialoguesViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/20.
//

import UIKit
import NSObject_Rx

class HarmonyDialoguesViewController: StressReliefAccessViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var robotControl: UIButton!
    @IBOutlet weak var DialogueControl: UIButton!
    
    @IBOutlet weak var dialoguesTable: UITableView!
    
    var alixyType = DialoguesAlixyType.bot {
        didSet{
            getAlyDialoguesInfoList()
        }
    }
    
    var dialoguesList:[DialoguesInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAlyDialoguesInfoList()
    }
    
    func getAlyDialoguesInfoList(){
        dialoguesList = AlixyHub.shared.dialoguesAlyArray.filter { dialoguesInfo in
            
            if self.alixyType == .bot {
                
                if dialoguesInfo.isBot == true {
                    if AlixyHub.shared.alixyMmkv?.string(forKey: "alyBlockBot" + dialoguesInfo.remoteId) != nil {
                        return false
                    }else{
                        return true
                    }
                }else{
                    return false
                }
                
            }else {
                
                if dialoguesInfo.isBot == false {
                    if AlixyHub.shared.alixyMmkv?.string(forKey: "alyBlockBotCreater" + dialoguesInfo.remoteId) != nil {
                        return false
                    }else{
                        return true
                    }
                }else{
                    return false
                }
            }
        }
        self.dialoguesTable.reloadData()
    }
    
    @IBAction func configureRobotPersonaWithTraits(sender:UIButton){
        sender.isSelected = true
        sender.isUserInteractionEnabled = false
        
        if sender == robotControl {
            DialogueControl.isSelected = false
            DialogueControl.isUserInteractionEnabled = true
            self.alixyType = .bot
        }else{
            robotControl.isSelected = false
            robotControl.isUserInteractionEnabled = true
            self.alixyType = .user
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dialoguesCell = tableView.dequeueReusableCell(withClass: DialoguesTableViewCell.self)
        dialoguesCell.dialoguesInfo = dialoguesList![indexPath.section]
        return dialoguesCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dialoguesInfo = dialoguesList![indexPath.section]
        let reliefAly = AlixyHub.shared.reliefRoverBots?.first(where: { reliefRoverBot in
            if self.alixyType == .bot {
                return reliefRoverBot.botId == dialoguesInfo.remoteId
            }else{
                return reliefRoverBot.botCreaterId == dialoguesInfo.remoteId
            }
        })
        if reliefAly != nil{
            let dialoguesDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: DialoguesDetailViewController.self)
            dialoguesDetailController?.alixyType = self.alixyType
            dialoguesDetailController!.relieAlyBot = reliefAly
            self.navigationController?.pushViewController(dialoguesDetailController!)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let dialoguesListCount = self.dialoguesList?.count ?? 0
        if dialoguesListCount > 0 {
            return dialoguesListCount
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
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
