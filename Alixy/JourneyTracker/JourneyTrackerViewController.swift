//
//  JourneyTrackerViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/18.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class JourneyTrackerViewController: StressReliefAccessViewController {

    @IBOutlet weak var trackerCollection: UICollectionView!
    
    let lifeCollectionDataSource = BehaviorSubject<[ReliefRoverBot]>(value: [])
    
    let edgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        initCollectionFlowLayout(itemSpacing: 24, edgeInsets: edgeInsets)
        
        NotificationCenter.default.rx.notification(Notification.Name("trackerListChanged"))
            .subscribe { _ in
                self.getJourneyTrackerDatas(false, edgeInsetsLeft: 12,shuffled: false)
            }
            .disposed(by: rx.disposeBag)
        
        getJourneyTrackerDatas(true,edgeInsetsLeft:12,shuffled: true)
    }
    
    
    func initCollectionFlowLayout(itemSpacing:CGFloat,edgeInsets:UIEdgeInsets){
        let interactiveCollectionLayout = UICollectionViewFlowLayout()
        var collectionItemSpacing = 0.0
        if  itemSpacing > 0 {
            collectionItemSpacing = itemSpacing
            interactiveCollectionLayout.scrollDirection = .vertical
            interactiveCollectionLayout.minimumLineSpacing = collectionItemSpacing
            interactiveCollectionLayout.sectionInset = edgeInsets
            interactiveCollectionLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 12, 364)
            trackerCollection.setCollectionViewLayout(interactiveCollectionLayout, animated: true)
        }
        
        lifeCollectionDataSource
            .bind(to: trackerCollection.rx.items(cellIdentifier: "TracterCollectionViewCell", cellType: TracterCollectionViewCell.self)){ trackerIndex,trackerModel,trackerCell in
                trackerCell.reliefRoverBot = trackerModel
                trackerCell.botCreaterImageTaped = { [weak self] in
                    if let self = self {
                        
                        if let reliefReverBot = try? AlixyHub.shared.alixyRoverBot.value(),reliefReverBot.botCreaterId == trackerModel.botCreaterId {
                            return
                        }
                        
                        let lifeScribeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: LifeScribeViewController.self)
                        lifeScribeController?.alixyCenterState = 1
                        lifeScribeController?.relieAlyBot.onNext(trackerModel)
                        lifeScribeController?.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(lifeScribeController!)
                    }
                }
            }
            .disposed(by: rx.disposeBag)
        
        trackerCollection
            .rx.modelSelected(ReliefRoverBot.self)
            .subscribe(onNext: { [weak self] model in
                if let self = self {
                    if let tiveHavenDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: TiveHavenDetailViewController.self) {
                        tiveHavenDetailViewController.hidesBottomBarWhenPushed = true
                        tiveHavenDetailViewController.relieAlyBot = model
                        self.navigationController?.pushViewController(tiveHavenDetailViewController)
                    }
                }
            })
            .disposed(by: rx.disposeBag)
        
    }

    func getJourneyTrackerDatas(_ alixyFlag:Bool, edgeInsetsLeft:CGFloat,shuffled:Bool){
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
                    if let _ = alyMmkv.string(forKey: "alyBlockHaven" + reliefRoverBot.botCreaterId) {
                        return true
                    }else if reliefRoverBot.trackerPics.count == 0 {
                        return true
                    } else{
                        return false
                    }
                }
                interactiveDataTemp = reliefRoverBots
            }
            
            DispatchQueue.main.async {
                if alixyFlag == true && edgeInsetsLeft > 0 {
                    MCToast.dismis()
                }
                
                self.lifeCollectionDataSource.onNext(interactiveDataTemp)
            }
        }
    }

}
