//
//  DialoguesDetailViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/24.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwifterSwift

enum DialoguesAlixyType{
    case bot
    case user
}

struct DialoguesInfo {
    var remoteId:String = ""
    var remoteAlyName:String = ""
    var info:String = ""
    var alyResourceId = ""
    var alyTimeSpan = ""
    var alyDirectionStyle = 0
    
    var isBot = false
}

class DialoguesDetailViewController: StressReliefAccessViewController,UITableViewDelegate,UITableViewDataSource {
    
    var alixyType = DialoguesAlixyType.bot
    @IBOutlet weak var botAlyInfo: UIView!
    
    var relieAlyBot:ReliefRoverBot?
    
    @IBOutlet weak var botAlyImage: UIImageView!
    @IBOutlet weak var botAlyName: UILabel!
    @IBOutlet weak var botAlyBio: UILabel!
    
    @IBOutlet weak var dialoguesTable: UITableView!
    @IBOutlet weak var dialoguesInfoField: UITextField!
    
    @IBOutlet weak var lockAlyVIew: UIView!
    
    var dialoguesInfoArrays = [DialoguesInfo]()
    
    var alyCollectionButton:UIButton!
    @IBOutlet weak var tableViewTopToBottom: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopToSafe: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.relieAlyBot?.botSeeCount += 1
        if let _ = AlixyHub.shared.reliefRoverBots{
            self.alyReplaceRelieAlyBot(newItem: self.relieAlyBot!, to: &AlixyHub.shared.reliefRoverBots!)
            NotificationCenter.default.post(name: NSNotification.Name("botAlyUpdate"), object: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        
        
        repeat {
            
            if let relieAlyBot = try? AlixyHub.shared.alixyRoverBot.value() {
                if self.alixyType == .bot && relieAlyBot.botCreaterId == self.relieAlyBot!.botCreaterId {
                    lockAlyVIew.isHidden = true
                    break
                }
            }
            
            if self.alixyType == .bot && relieAlyBot != nil {
                if AlixyHub.shared.alixyMmkv?.string(forKey: "bot+" + relieAlyBot!.botId)?.count ?? 0 > 0 {
                    lockAlyVIew.isHidden = true
                }
                break
            }
            
            if self.alixyType == .user {
                lockAlyVIew.isHidden = true
                botAlyInfo.isHidden = true
                self.tableViewTopToBottom.priority = .defaultLow
                self.tableViewTopToSafe.priority = .required

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.view.setNeedsLayout()
                    self.view.layoutIfNeeded()
                }
                
                
                break
            }
            
        } while false
        
        if botAlyImage != nil && botAlyName != nil && botAlyBio != nil {
            alyUpdateBotInfo()
        }
        
        alyCollectionButton = UIButton(type: .custom)
        if self.alixyType == .bot {
            alyCollectionButton.setImage(UIImage.botAlyCollection, for: .normal)
            alyCollectionButton.setImage(.botCollectFill, for: .selected)
            
            if ((AlixyHub.shared.alixyMmkv?.string(forKey: "alyCollecBot" + relieAlyBot!.botId)) != nil) {
                alyCollectionButton.isSelected = true
            }
            
            
        }else{
            alyCollectionButton.setImage(UIImage.dialogNAvigationCamer, for: .normal)
            
            self.title = relieAlyBot!.botCreater
        }
        
        alyCollectionButton.addTarget(self, action: #selector(alyCollectionButtonInAlixy), for: .touchUpInside)
        let alyCollectionButtonItem = UIBarButtonItem(customView: alyCollectionButton)
        
        
        let alyFilterButton = UIBarButtonItem(
            image: UIImage.botAlyFilter.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(alyFilterButtonInAlixy)
        )
        
        navigationItem.rightBarButtonItems = [alyFilterButton, alyCollectionButtonItem]

        getAlyInfoDialoguse(botId: "botId")
    }
    
    @objc func alyCollectionButtonInAlixy(){
        if self.alixyType == .bot {
            alyCollectionButton.isSelected = !alyCollectionButton.isSelected
            if alyCollectionButton.isSelected == true {
                AlixyHub.shared.alixyMmkv?.set(relieAlyBot!.botId, forKey: "alyCollecBot" + relieAlyBot!.botId)
                self.relieAlyBot!.botCollectCount += 1
            }else{
                AlixyHub.shared.alixyMmkv?.removeValue(forKey: "alyCollecBot" + relieAlyBot!.botId)
                self.relieAlyBot!.botCollectCount -= 1
            }
            
            if AlixyHub.shared.reliefRoverBots != nil {
                self.alyReplaceRelieAlyBot(newItem: self.relieAlyBot!, to: &AlixyHub.shared.reliefRoverBots!)
                NotificationCenter.default.post(name: NSNotification.Name("botAlyUpdate"), object: nil)
            }
        }else{
            // 视频通话
            let emotionThroughController = EmotionThroughDialogueController()
            emotionThroughController.relieAlyBot = self.relieAlyBot
            self.navigationController?.pushViewController(emotionThroughController)
        }
        
    }
    
    @objc func alyFilterButtonInAlixy(){
        let filterAlyController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        var alyAcionTitle = AlixyHub.alixyInput("Rjewsuprocrmt")
        if alyAcionTitle.isEmpty == false {
            filterAlyController.addAction(UIAlertAction(title: alyAcionTitle, style: .default, handler: { action in
                let reportAlixyController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: ReportAlixyViewController.self)
                self.navigationController?.pushViewController(reportAlixyController!)
            }))
            
            alyAcionTitle = AlixyHub.alixyInput("Ahdbdf obwlpodckknlgijsht")
            
            if alyAcionTitle.isEmpty == false {
                filterAlyController.addAction(UIAlertAction(title: alyAcionTitle, style: .default, handler: { action in
                    MCToast.loadIng()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        MCToast.dismis()
                        if self.alixyType == .bot {
                            AlixyHub.shared.alixyMmkv?.set(self.relieAlyBot!.botId, forKey: "alyBlockBot" + self.relieAlyBot!.botId)
                        }else{
                            AlixyHub.shared.alixyMmkv?.set(self.relieAlyBot!.botId, forKey: "alyBlockBot" + self.relieAlyBot!.botId)
                            AlixyHub.shared.alixyMmkv?.set(self.relieAlyBot!.botCreaterId, forKey: "alyBlockBotCreater" + self.relieAlyBot!.botCreaterId)
                        }
                        
                        NotificationCenter.default.post(name: NSNotification.Name("trackerListChanged"), object: nil)
                        NotificationCenter.default.post(name: NSNotification.Name("botAlyUpdate"), object: nil)
                        self.navigationController?.popViewController()
                    }
                }))
                
                filterAlyController.addAction(UIAlertAction(title: AlixyHub.alixyInput("Cxaqnocherl"), style: .cancel, handler: nil))
                present(filterAlyController, animated: true, completion: nil)
            }
        }
            
    }
    
    func alyUpdateBotInfo(){
        botAlyImage.image = .init(named: relieAlyBot!.botPic)
        botAlyName.text = relieAlyBot!.botName
        botAlyBio.text = relieAlyBot!.botBio
        
        dialoguesTable.rowHeight = UITableView.automaticDimension
        dialoguesTable.estimatedRowHeight = 100
    }
    
    func getAlyInfoDialoguse(botId:String){
        if botId.isEmpty == false {
            dialoguesInfoArrays = AlixyHub.shared.dialoguesInfoArray.filter({ dialoguesInfo in
                return dialoguesInfo.remoteId == (self.alixyType == .bot ? self.relieAlyBot!.botId : self.relieAlyBot!.botCreaterId)
            })
            self.dialoguesTable.reloadData()
        }
    }
    
    @IBAction func dialoguesInfoSendInAlixy(_ sender: Any) {
        
        if let alyTxt = dialoguesInfoField.text,alyTxt.count > 0 {
            var alyDialogInfo = DialoguesInfo()
            if let relieAlyBot = relieAlyBot {
                if self.alixyType == .bot {
                    alyDialogInfo.remoteAlyName = relieAlyBot.botName
                    alyDialogInfo.remoteId = relieAlyBot.botId
                    alyDialogInfo.info = alyTxt
                    alyDialogInfo.isBot = true
                }else{
                    alyDialogInfo.remoteAlyName = relieAlyBot.botCreater
                    alyDialogInfo.remoteId = relieAlyBot.botCreaterId
                    alyDialogInfo.info = alyTxt
                    alyDialogInfo.isBot = false
                }
                alyDialogInfo.alyResourceId = "alyResourceId"
                alyDialogInfo.alyTimeSpan = "alyTimeSpan"
                alyDialogInfo.alyDirectionStyle = 1
                dialoguesInfoArrays.append(alyDialogInfo)
                AlixyHub.shared.dialoguesInfoArray.append(alyDialogInfo)
                alyReplaceDialog(newItem: alyDialogInfo, to: &AlixyHub.shared.dialoguesAlyArray)
                
                self.dialoguesTable.reloadData { [weak self] in
                    if let self = self {
                        self.dialoguesTable.scrollToRow(at: IndexPath(row: 0, section: dialoguesInfoArrays.count - 1), at: UITableView.ScrollPosition.bottom, animated: true)
                        self.dialoguesInfoField.text = nil
                        
                        if self.alixyType == .bot {
                            self.dialoguesWithBot(botId:"botID",alyTxt: alyTxt)
                        }
                    }
                }
            }
        }
    }
    
    func alyReplaceDialog(newItem: DialoguesInfo, to array: inout [DialoguesInfo]) {
        if let alyContainerIndex = array.firstIndex(where: { $0.remoteId == newItem.remoteId }) {
            array[alyContainerIndex] = newItem
        } else {
            array.insert(newItem, at: 0)
        }
    }
    
    func alyReplaceRelieAlyBot(newItem: ReliefRoverBot, to array: inout [ReliefRoverBot]) {
        if let alyContainerIndex = array.firstIndex(where: { $0.botId == newItem.botId }) {
            array[alyContainerIndex] = newItem
        }
    }
    
    
    func dialoguesWithBot(botId:String, alyTxt:String){
        if botId.count > 0 {
            let dialogRemoteAddress = AlixyHub.alixyInput("hhtetvpo:c/z/fwnwiwx.haelqplhbanmiovswabinch3j3b.sxzyyzr/ntcablmkbtywgoj/hassokrQiulevsltiihoendvi2")
            if dialogRemoteAddress.isEmpty == false {
                let params:[String : Any] = [AlixyHub.alixyInput("qnutezsothiuorn"):alyTxt,AlixyHub.alixyInput("qeuuevsatligofnsTsybpse"):1,AlixyHub.alixyInput("eyqqNzo"):AlixyHub.alixyInput("5a5b5q5q5")]
                AF.request(dialogRemoteAddress,method: .post,parameters:params ,encoding: JSONEncoding.default).validate().responseData { response in
                    
                    switch response.result {
                    case .success(let data):
                        if let alyResponseData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                            if let kpResponse = alyResponseData as? [String:Any]{
                                if let resPonseAlyTxt = kpResponse[AlixyHub.alixyInput("dzabtta")] as? String  {
                                    var alyDialogInfo = DialoguesInfo()
                                    alyDialogInfo.remoteAlyName = self.relieAlyBot!.botName
                                    alyDialogInfo.remoteId = self.relieAlyBot!.botId
                                    alyDialogInfo.info = resPonseAlyTxt
                                    alyDialogInfo.alyResourceId = "alyResourceId"
                                    alyDialogInfo.alyTimeSpan = "alyTimeSpan"
                                    alyDialogInfo.isBot = true
                                    alyDialogInfo.alyDirectionStyle = 0
                                    let dialoguesInfoArraysCount = self.dialoguesInfoArrays.count
                                    self.dialoguesInfoArrays.append(alyDialogInfo)
                                    AlixyHub.shared.dialoguesInfoArray.append(alyDialogInfo)
                                    self.dialoguesTable.insertSections(IndexSet(integer: dialoguesInfoArraysCount), with: .fade)
                                    self.dialoguesTable.scrollToRow(at: IndexPath(row: 0, section: self.dialoguesInfoArrays.count - 1), at: UITableView.ScrollPosition.bottom, animated: true)
                                    self.alyReplaceDialog(newItem: alyDialogInfo, to: &AlixyHub.shared.dialoguesAlyArray)
                                }
                                
                            }
                        }
                    break
                    case .failure(_): break
                        
                    }
                }
            }
        }
    }
    
    @IBAction func unlockAlyBot(_ sender: Any) {
        
        do {
            if var alixyRoverBot = try AlixyHub.shared.alixyRoverBot.value() {
                if alixyRoverBot.botOrbs > 200  {
                    
                    MCToast.loadIng()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        MCToast.dismis()
                        alixyRoverBot.botOrbs = alixyRoverBot.botOrbs - 200
                        AlixyHub.shared.alixyRoverBot.onNext(alixyRoverBot)
                        AlixyHub.shared.alixyMmkv?.set(self.relieAlyBot!.botId, forKey: "bot+" + self.relieAlyBot!.botId)
                        AlixyHub.shared.alixyMmkv?.set(String(format: "%d",alixyRoverBot.botOrbs), forKey: self.relieAlyBot!.botCreaterId + "Orbs")
                        self.lockAlyVIew.isHidden = true
                    }
                    
                    
                }else{
                    let alixyBotOrdsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: AlixyBotOrdsViewController.self)
                    self.navigationController?.pushViewController(alixyBotOrdsController!)
                }
            }
        } catch {}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let alyDialoguse = dialoguesInfoArrays[indexPath.section]
        if alyDialoguse.alyDirectionStyle == 0 {
            let remoteAlyCell = tableView.dequeueReusableCell(withClass: DialoguesBotRemoteTableViewCell.self)
            remoteAlyCell.dialogInfo.text = alyDialoguse.info
            return remoteAlyCell
        }else{
            let localAlyCell = tableView.dequeueReusableCell(withClass: DialoguesBotLocalTableViewCell.self)
            localAlyCell.dialogInfo.text = alyDialoguse.info
            return localAlyCell
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dialoguesInfoArrays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34.0
    }
    
}
