//
//  LifeScribeViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/18.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class LifeScribeViewController: StressReliefAccessViewController {

    @IBOutlet weak var menuIndicatorLeft: NSLayoutConstraint!
    
    @IBOutlet weak var alixyNoData: UILabel!
    @IBOutlet weak var lifeScribeCollection: UICollectionView!
    
    var lifeSwitchControlSelect:UIButton!
    @IBOutlet weak var backgroundAlyHeight: NSLayoutConstraint!
    @IBOutlet weak var createrAlyTop: NSLayoutConstraint!
    
    @IBOutlet weak var createrImage: UIImageView!
    @IBOutlet weak var createrName: UILabel!
    @IBOutlet weak var createrNumber: UILabel!
    @IBOutlet weak var createrInfo: UILabel!
    @IBOutlet weak var aliButtonOne: UIButton!
    @IBOutlet weak var alyButtonTwo: UIButton!
    @IBOutlet weak var alyButtonThree: UIButton!
    
    @IBOutlet weak var trackerAlyNumber: UILabel!
    @IBOutlet weak var trackerAlyFavoriteMe: UILabel!
    @IBOutlet weak var trackerAlyFavirite: UILabel!
    
    var alixyCacheBots:[ReliefRoverBot]?
    
    var alixyCenterState = 0 // 0 自己的主页 1 他人的主页
    
    let edgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    let lifeCollectionDataSource = BehaviorSubject<[ReliefRoverBot]>(value: [])
    
    let relieAlyBot = BehaviorSubject<ReliefRoverBot?>(value: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionFlowLayout(itemSpacing: 12,edgeInsets: edgeInsets)
        alixyNoData.isHidden = true
        if let menuControl = self.view.viewWithTag(100) as? UIButton {
            lifeSwitchControlSelect = menuControl
        }
        
        if alixyCenterState == 0 {
            alyButtonThree.isHidden = true
            
            AlixyHub.shared.alixyRoverBot
                .compactMap{$0}
                .subscribe(onNext: { alixyRoverBot in
                    self.relieAlyBot.onNext(alixyRoverBot)
                })
                .disposed(by: rx.disposeBag)
            
            navigationController?.setNavigationBarHidden(true, animated: true)
        }else{
            navigationController?.setNavigationBarHidden(false, animated: true)
            
            let alyFilterButton = UIBarButtonItem(
                image: UIImage.botAlyFilter.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(alyFilterButtonInAlixy)
            )
            self.navigationItem.rightBarButtonItem = alyFilterButton
            
            createrAlyTop.constant = 112
            backgroundAlyHeight.constant = 367
            aliButtonOne.setImage(.alixyLifeFollow, for: .normal)
            aliButtonOne.setTitle("  " + AlixyHub.alixyInput("Fnodlnloobw"), for: .normal)
            aliButtonOne.setImage(.alixyLifeFollows, for: .selected)
            aliButtonOne.setTitle("  " + AlixyHub.alixyInput("Fooklnluosweeud"), for: .selected)
            
            alyButtonTwo.setImage(UIImage.alixyLifeContacts, for: .normal)
            alyButtonTwo.setTitle("  " + AlixyHub.alixyInput("Cnhdatt"), for: .normal)
            
            if let relieAlyBot = try? relieAlyBot.value() {
                if AlixyHub.shared.alixyMmkv?.string(forKey: "alyFollowedCreater" + relieAlyBot.botCreaterId) != nil {
                    aliButtonOne.isSelected = true
                }else{
                    aliButtonOne.isSelected = false
                }
            }
            
        }
        
        updateRelieAlyBot()
        
        NotificationCenter.default.rx.notification(Notification.Name("botAlyUpdate"))
            .subscribe { _ in
                
                if var lifeBotDatas = try? self.lifeCollectionDataSource.value() {
                    
                    for reliefRoverBot in AlixyHub.shared.reliefRoverBots! {
                        if let index = lifeBotDatas.firstIndex(where: { $0.botId == reliefRoverBot.botId }) {
                            lifeBotDatas[index] = reliefRoverBot
                        }
                    }
                    
                    self.lifeCollectionDataSource.onNext(lifeBotDatas)
                }
                
                if var lifeBotDatas =  self.alixyCacheBots {
                    
                    for reliefRoverBot in AlixyHub.shared.reliefRoverBots! {
                        if let index = lifeBotDatas.firstIndex(where: { $0.botId == reliefRoverBot.botId }) {
                            lifeBotDatas[index] = reliefRoverBot
                        }
                    }
                    self.alixyCacheBots = lifeBotDatas
                }
            }
            .disposed(by: rx.disposeBag)
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
                        if let relieAlyBot = try? self.relieAlyBot.value() {
                            AlixyHub.shared.alixyMmkv?.set(relieAlyBot.botCreaterId, forKey: "alyBlockBotCreater" + relieAlyBot.botCreaterId)
                            NotificationCenter.default.post(name: NSNotification.Name("trackerListChanged"), object: nil)
                            NotificationCenter.default.post(name: NSNotification.Name("botAlyUpdate"), object: nil)
                            self.navigationController?.popViewController()
                        }
                    }
                }))
                
                filterAlyController.addAction(UIAlertAction(title: AlixyHub.alixyInput("Cxaqnocherl"), style: .cancel, handler: nil))
                present(filterAlyController, animated: true, completion: nil)
            }
        }
    }
    
    func updateRelieAlyBot(){
        
        relieAlyBot
            .compactMap{$0}
            .subscribe(onNext: { [weak self] relieAlyBot in
                if let self = self {
                    self.trackerAlyNumber.text = String(format: "%d", relieAlyBot.trackerNumber)
                    self.trackerAlyFavoriteMe.text = String(format: "%d", relieAlyBot.trackerFavoriteMe)
                    self.trackerAlyFavirite.text = String(format: "%d", relieAlyBot.trackerFavorite)
                    
                    if let aliResultImage = relieAlyBot.traclerCacheImaeg {
                        self.createrImage.image = aliResultImage
                    }else{
                        self.createrImage.image = UIImage(named: relieAlyBot.botCreaterId)
                    }
                    
                    self.createrName.text = relieAlyBot.botCreater
                    self.createrNumber.text = String(format: "@%d", relieAlyBot.createNumber)
                    self.createrInfo.text = relieAlyBot.botCreaterBio
                    
                    
                    if let relieAlyBots = AlixyHub.shared.reliefRoverBots?.filter({$0.botCreaterId == relieAlyBot.botCreaterId}) {
                        self.alixyCacheBots = relieAlyBots
                        self.lifeCollectionDataSource.onNext(relieAlyBots)
                    }
                }
            })
            .disposed(by: rx.disposeBag)
        
        
    }
    
    @IBAction func centerButtonInAlixy(_ sender: UIButton) {
        switch sender.tag {
        case 200:
            if self.alixyCenterState == 0 {
                let editAlixyUserInfo = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: EditAlixyUserInfoViewController.self)
                editAlixyUserInfo?.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(editAlixyUserInfo!)
                
            }else{
                MCToast.loadIng()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    MCToast.dismis()
                    sender.isSelected = !sender.isSelected
                    if var relieAlyBot = try? self.relieAlyBot.value() {
                        if sender.isSelected == true {
                            AlixyHub.shared.alixyMmkv?.set(relieAlyBot.botCreaterId, forKey: "alyFollowedCreater" + relieAlyBot.botCreaterId)
                            relieAlyBot.trackerFavoriteMe += 1
                        }else{
                            AlixyHub.shared.alixyMmkv?.removeValue(forKey: "alyFollowedCreater" + relieAlyBot.botCreaterId)
                            relieAlyBot.trackerFavoriteMe -= 1
                        }
                        self.relieAlyBot.onNext(relieAlyBot)
                    }
                }
            }
            
        case 201:
            if self.alixyCenterState == 0 {
                let alixySettingController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: AlixySettingTableViewController.self)
                alixySettingController?.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(alixySettingController!)
                
            }else{
                if let relieAlyBot = try? self.relieAlyBot.value() {
                    let dialoguesDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: DialoguesDetailViewController.self)
                    dialoguesDetailController!.alixyType = .user
                    dialoguesDetailController!.relieAlyBot = relieAlyBot
                    self.navigationController?.pushViewController(dialoguesDetailController!)
                }
            }
        case 202:
            // 视频通话
            let emotionThroughController = EmotionThroughDialogueController()
            emotionThroughController.relieAlyBot = try? self.relieAlyBot.value()
            self.navigationController?.pushViewController(emotionThroughController)
            break
        default:break
        }
    }
    
    
    @IBAction func liftMenuSwitchInAlixy(_ sender: UIButton) {
        sender.isSelected = true
        sender.isUserInteractionEnabled = false
        
        lifeSwitchControlSelect.isSelected = false
        lifeSwitchControlSelect.isUserInteractionEnabled = true
        
        lifeSwitchControlSelect = sender
        let senderTag = sender.tag - 100
        if senderTag >= 0 {
            menuIndicatorLeft.constant = CGFloat(senderTag) * (self.view.bounds.size.width - 60)/2
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
        
        getBotInAlixy(senderTag: senderTag, alyNeedLoad: true)
        
    }
    
    func getBotInAlixy(senderTag:Int,alyNeedLoad:Bool){
        if senderTag > 0 {
            if alyNeedLoad == true {
                MCToast.loadIng()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if alyNeedLoad == true {
                    MCToast.dismis()
                }
                let reliefRoverBots = AlixyHub.shared.reliefRoverBots?.filter({ reliefRoverBot in
                    if AlixyHub.shared.alixyMmkv?.string(forKey: "alyCollecBot" + reliefRoverBot.botId) != nil {
                        return true
                    }else{
                        return false
                    }
                })
                self.lifeCollectionDataSource.onNext(reliefRoverBots!)
            }
        }else{
            
            if alyNeedLoad == true {
                MCToast.loadIng()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if alyNeedLoad == true {
                    MCToast.dismis()
                }
                self.lifeCollectionDataSource.onNext(self.alixyCacheBots!)
            }
        }
    }
    
    func initCollectionFlowLayout(itemSpacing:CGFloat,edgeInsets:UIEdgeInsets){
        let interactiveCollectionLayout = UICollectionViewFlowLayout()
        var collectionItemSpacing = 0.0
        if  itemSpacing > 0 {
            collectionItemSpacing = itemSpacing
            interactiveCollectionLayout.scrollDirection = .horizontal
            interactiveCollectionLayout.minimumInteritemSpacing = collectionItemSpacing
            interactiveCollectionLayout.sectionInset = edgeInsets
            interactiveCollectionLayout.itemSize = CGSizeMake(175, 245)
            lifeScribeCollection.setCollectionViewLayout(interactiveCollectionLayout, animated: true)
            lifeScribeCollection.showsHorizontalScrollIndicator = false
        }
        
        lifeCollectionDataSource
            .bind(to: lifeScribeCollection.rx.items(cellIdentifier: "InteractiveHavenCollectionViewCell", cellType: InteractiveHavenCollectionViewCell.self)){ interactiveIndex,interactiveModel,interactiveCell in
                interactiveCell.reliefReverBot = interactiveModel
            }
            .disposed(by: rx.disposeBag)
        
        lifeScribeCollection.rx.modelSelected(ReliefRoverBot.self)
            .subscribe(onNext: { [weak self] reliefRoverBot in
                if let self = self {
                    let dialoguesDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: DialoguesDetailViewController.self)
                    dialoguesDetailController?.hidesBottomBarWhenPushed = true
                    dialoguesDetailController?.relieAlyBot = reliefRoverBot
                    self.navigationController?.pushViewController(dialoguesDetailController!)
                }
            })
            .disposed(by: rx.disposeBag)
        
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
