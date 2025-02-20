//
//  TiveHavenDetailViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import SVProgressHUD

class TiveHavenDetailViewController: StressReliefAccessViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var tiveHavenCollection: UICollectionView!
    @IBOutlet weak var tiveHavenFieldComment: UITextField!
    @IBOutlet weak var tivehavenFavoriteButton: UIButton!
    @IBOutlet weak var trackerImageCount: UILabel!
    
    var trackerDetailComment:TrackerDetailComment?
    
    var relieAlyBot:ReliefRoverBot?
    
    var commentBackground:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        initCollectionFlowLayout(itemSpacing: 0,edgeInsets: .zero)
        
        updateAlyTrackerDetail()
        
        let alyFilterButton = UIBarButtonItem(
            image: UIImage.botAlyFilter.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(alyFilterButtonInAlixy)
        )
        self.navigationItem.rightBarButtonItem = alyFilterButton
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
                        AlixyHub.shared.alixyMmkv?.set(self.relieAlyBot!.botCreaterId, forKey: "alyBlockHaven" + self.relieAlyBot!.botCreaterId)
                        NotificationCenter.default.post(name: NSNotification.Name("trackerListChanged"), object: nil)
                        self.navigationController?.popViewController()
                    }
                }))
                
                filterAlyController.addAction(UIAlertAction(title: AlixyHub.alixyInput("Cxaqnocherl"), style: .cancel, handler: nil))
                present(filterAlyController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func commentInAlixy(_ sender: Any) {
        tiveHavenFieldComment.resignFirstResponder()
        DispatchQueue.main.async {
            MCToast.loadIng()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                MCToast.dismis()
                MCToast.mc_text(AlixyHub.alixyInput("Tchpaanpkt zyhohuz vfvotra gyvotuhre iczoymdmieznvtv,r awney kwjiclnlu drpemvpioegwa ribtc ratsl rsiodohno cavsn wpeodsasxiqbylke"))
                self.tiveHavenFieldComment.text = nil
            }
        }
    }
    
    func updateAlyTrackerDetail(){
        if let relieAlyBot = self.relieAlyBot {
            trackerImageCount.text = "1/\(self.relieAlyBot!.trackerPics.count)"
            if AlixyHub.shared.alixyMmkv?.string(forKey: "alyFavoriteHaven" + relieAlyBot.botCreaterId) != nil {
                tivehavenFavoriteButton.isSelected = true
            }else{
                tivehavenFavoriteButton.isSelected = false
            }
            tiveHavenCollection.reloadData()
        }
    }
    
    @IBAction func showCommentInAlixy(_ sender: Any) {
        if let trackerDetailComment = Bundle.main.loadNibNamed("TrackerDetailComment", owner: nil)?.first as? TrackerDetailComment {
            
            commentBackground = UIView()
            commentBackground?.backgroundColor = UIColor.init(hexString: "#121315",transparency: 0.7)
            self.view.addSubview(commentBackground!)
            commentBackground!.snp.makeConstraints { make in
                make.left.top.right.bottom.equalToSuperview()
            }
            
            commentBackground?.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: { [weak self] _ in
                    if let self = self {
                        
                        
                        UIView.animate(withDuration: 0.25) {
                            self.trackerDetailComment!.snp.updateConstraints { make in
                                make.bottom.equalToSuperview().offset(426)
                            }
                            self.view.layoutIfNeeded()
                        } completion: { done in
                            self.commentBackground?.removeFromSuperview()
                            self.trackerDetailComment?.removeFromSuperview()
                        }
                    }
                })
                .disposed(by: rx.disposeBag)
            
            
            trackerDetailComment.layer.cornerRadius = 54
            trackerDetailComment.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            trackerDetailComment.layer.masksToBounds = true
            
            self.trackerDetailComment = trackerDetailComment
            
            self.view.addSubview(self.trackerDetailComment!)
            self.trackerDetailComment!.snp.makeConstraints({ make in
                make.left.right.equalToSuperview()
                make.height.equalTo(426)
                make.bottom.equalToSuperview().offset(426)
            })
            
            self.view.layoutIfNeeded()
            
            
            UIView.animate(withDuration: 0.25) {
                self.trackerDetailComment!.snp.updateConstraints { make in
                    make.bottom.equalToSuperview()
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func favoriteInAlixy(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            AlixyHub.shared.alixyMmkv?.set(relieAlyBot!.botCreaterId, forKey: "alyFavoriteHaven" + relieAlyBot!.botCreaterId)
        }else{
            AlixyHub.shared.alixyMmkv?.removeValue(forKey: "alyFavoriteHaven" + relieAlyBot!.botCreaterId)
        }
    }
    
    func initCollectionFlowLayout(itemSpacing:CGFloat,edgeInsets:UIEdgeInsets){
        let interactiveCollectionLayout = UICollectionViewFlowLayout()
        var collectionItemSpacing = 0.0
        if  itemSpacing >= 0 {
            collectionItemSpacing = itemSpacing
            interactiveCollectionLayout.minimumInteritemSpacing = collectionItemSpacing
            interactiveCollectionLayout.minimumLineSpacing = collectionItemSpacing
            interactiveCollectionLayout.sectionInset = edgeInsets
            interactiveCollectionLayout.scrollDirection = .horizontal
            let bottomSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
            let topSafeAreaHeight = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
            let itemSizeHeight = UIScreen.main.bounds.size.height - bottomSafeAreaHeight - 105 - (self.navigationController?.navigationBar.height)! - topSafeAreaHeight
            interactiveCollectionLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 24, itemSizeHeight)
            tiveHavenCollection.setCollectionViewLayout(interactiveCollectionLayout, animated: true)
            tiveHavenCollection.delegate = self
            tiveHavenCollection.dataSource = self
        }
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetPage = Int(scrollView.contentOffset.x / (self.view.bounds.size.width - 24)) + 1
        trackerImageCount.text = "\(offsetPage)/\(self.relieAlyBot!.trackerPics.count)"
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tracterDetailCollectionViewCell = collectionView.dequeueReusableCell(withClass: TracterDetailCollectionViewCell.self, for: indexPath)
        tracterDetailCollectionViewCell.relieAlyBot = self.relieAlyBot
        tracterDetailCollectionViewCell.trackerImage.image = .init(named: self.relieAlyBot!.trackerPics[indexPath.row])
        tracterDetailCollectionViewCell.botCreaterImageTaped = { [weak self] in
            if let self = self {
                
                if let reliefReverBot = try? AlixyHub.shared.alixyRoverBot.value(),reliefReverBot.botCreaterId == self.relieAlyBot!.botCreaterId {
                    return
                }
                
                let lifeScribeController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: LifeScribeViewController.self)
                lifeScribeController?.alixyCenterState = 1
                lifeScribeController?.relieAlyBot.onNext(self.relieAlyBot)
                self.navigationController?.pushViewController(lifeScribeController!)
            }
        }
        return tracterDetailCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.relieAlyBot == nil ? 0 : self.relieAlyBot!.trackerPics.count
    }

}
