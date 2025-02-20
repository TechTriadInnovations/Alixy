//
//  InteractiveHavenViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/18.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class InteractiveHavenViewController: StressReliefAccessViewController {

    @IBOutlet weak var interactiveCollection: UICollectionView!
    
    var nowSelectMenu:UIButton!
    
    let interactiveDataSource = BehaviorSubject<[ReliefRoverBot]>(value: [])
    
    let edgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 20, right: 12)
    
    @IBOutlet weak var menuAlixy: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowSelectMenu = menuAlixy
        
        initCollectionFlowLayout(itemSpacing: 12,edgeInsets: self.edgeInsets)
        
        interactiveDataSource
            .bind(to: interactiveCollection.rx.items(cellIdentifier: "InteractiveHavenCollectionViewCell", cellType: InteractiveHavenCollectionViewCell.self)){ interactiveIndex,interactiveModel,interactiveCell in
                interactiveCell.reliefReverBot = interactiveModel
                interactiveCell.botCreaterImageTaped = { [weak self] in
                    if let self = self {
                        
                        if let reliefReverBot = try? AlixyHub.shared.alixyRoverBot.value(),reliefReverBot.botCreaterId == interactiveModel.botCreaterId {
                            return
                        }
                        
                        let lifeScribeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: LifeScribeViewController.self)
                        lifeScribeController?.alixyCenterState = 1
                        lifeScribeController?.hidesBottomBarWhenPushed = true
                        lifeScribeController?.relieAlyBot.onNext(interactiveModel)
                        self.navigationController?.pushViewController(lifeScribeController!)
                    }
                }
            }
            .disposed(by: rx.disposeBag)
        
        interactiveCollection.rx.modelSelected(ReliefRoverBot.self)
            .subscribe(onNext: { [weak self] reliefRoverBot in
                if let self = self {
                    let dialoguesDetailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: DialoguesDetailViewController.self)
                    dialoguesDetailController?.hidesBottomBarWhenPushed = true
                    dialoguesDetailController?.relieAlyBot = reliefRoverBot
                    self.navigationController?.pushViewController(dialoguesDetailController!)
                }
            })
            .disposed(by: rx.disposeBag)
        
//        NotificationCenter.default.rx.notification(Notification.Name("botAlyChanged"))
//            .subscribe { _ in
//                self.getInteractiveHavenDatas(false, edgeInsetsLeft: 12, shuffled: false)
//            }
//            .disposed(by: rx.disposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name("botAlyUpdate"))
            .subscribe { _ in
                self.botInfoChanged()
            }
            .disposed(by: rx.disposeBag)
        
        getInteractiveHavenDatas(true,edgeInsetsLeft: 12,shuffled: true)
    }
    
    func botInfoChanged(){
        if var lifeBotDatas = try? self.interactiveDataSource.value() {
            
            for reliefRoverBot in AlixyHub.shared.reliefRoverBots! {
                if let index = lifeBotDatas.firstIndex(where: { $0.botId == reliefRoverBot.botId }) {
                    lifeBotDatas[index] = reliefRoverBot
                }
            }
            
            lifeBotDatas.removeAll { reliefRoverBot in
                
                if AlixyHub.shared.alixyMmkv?.string(forKey: "alyBlockBot" + reliefRoverBot.botId) != nil {
                    return true
                }else if AlixyHub.shared.alixyMmkv?.string(forKey: "alyBlockBotCreater" + reliefRoverBot.botCreaterId) != nil{
                    return true
                } else{
                    return false
                }
            }
            
            self.interactiveDataSource.onNext(lifeBotDatas)
        }
    }
    
    func getInteractiveHavenDatas(_ alixyFlag:Bool, edgeInsetsLeft:CGFloat,shuffled:Bool){
        if alixyFlag == true && edgeInsetsLeft > 0 {
            MCToast.loadIng()
        }
        DispatchQueue.global().async {
            
            if alixyFlag == true && edgeInsetsLeft > 0 {
                sleep(2)
            }
            var interactiveDataTemp:[ReliefRoverBot] = []
            if var reliefRoverBots = AlixyHub.shared.reliefRoverBots,let alyMmkv = AlixyHub.shared.alixyMmkv {
                
                if shuffled == true {
                    reliefRoverBots = reliefRoverBots.shuffled()
                }
                
                reliefRoverBots.removeAll { reliefRoverBot in
                    if let _ = alyMmkv.string(forKey: "alyBlockBot" + reliefRoverBot.botId) {
                        return true
                    }else if let _ = alyMmkv.string(forKey: "alyBlockBotCreater" + reliefRoverBot.botCreaterId) {
                        return true
                    }else{
                        return false
                    }
                }
                interactiveDataTemp = reliefRoverBots
            }
            
            DispatchQueue.main.async {
                if alixyFlag == true && edgeInsetsLeft > 0 {
                    MCToast.dismis()
                }
                
                self.interactiveDataSource.onNext(interactiveDataTemp)
                
                if interactiveDataTemp.count > 0 && edgeInsetsLeft > 0 && alixyFlag == true {
                    self.interactiveCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition.top, animated: false)
                }
            }
        }
    }
    
    func initCollectionFlowLayout(itemSpacing:CGFloat,edgeInsets:UIEdgeInsets){
        let interactiveCollectionLayout = UICollectionViewFlowLayout()
        var collectionItemSpacing = 0.0
        if  itemSpacing > 0 {
            collectionItemSpacing = itemSpacing
            interactiveCollectionLayout.minimumInteritemSpacing = collectionItemSpacing
            interactiveCollectionLayout.minimumLineSpacing = collectionItemSpacing
            interactiveCollectionLayout.sectionInset = edgeInsets
            interactiveCollectionLayout.itemSize = CGSizeMake((self.view.bounds.size.width - 36)/2, 245)
            interactiveCollection.setCollectionViewLayout(interactiveCollectionLayout, animated: true)
        }
        
        
    }
    
    @IBAction func menuReplaceInAlixy(_ sender: UIButton) {
        sender.isSelected = true
        sender.isUserInteractionEnabled = false
        
        nowSelectMenu.isSelected = false
        nowSelectMenu.isUserInteractionEnabled = true
        
        nowSelectMenu = sender
        
        getInteractiveHavenDatas(true,edgeInsetsLeft: 12,shuffled: true)
    }
    

}
