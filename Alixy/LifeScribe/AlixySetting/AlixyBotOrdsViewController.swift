//
//  AlixyBotOrdsViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/25.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD
import HandyJSON
import SwiftyStoreKit

class AlixyBotOrdsViewController: StressReliefAccessViewController {

    @IBOutlet weak var ordsCollection: UICollectionView!
    @IBOutlet weak var botOrds: UILabel!
    
    var botOrdsItems:[Any] = []
    
//    var alyOrdsParams = [[String:String]]()
    var alyOrdsParams = [OrdsParams]()
    
    let ordsCollectionItems = BehaviorSubject<[OrdsParams]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        
        ordsCollectionReset(itemSpacing: 12)
        
        AlixyHub.shared.alixyRoverBot
            .compactMap({ $0 })
            .subscribe(onNext: { [weak self] alixyRoverBot in
                if let self = self {
                    self.botOrds.text = "\(alixyRoverBot.botOrbs)"
                }
            })
            .disposed(by: rx.disposeBag)
        
        ordsCollectionItems.bind(to: ordsCollection.rx.items(cellIdentifier: "AlixyBotOrdsCollectionViewCell", cellType: AlixyBotOrdsCollectionViewCell.self)) { alixyOrdsIndex, alixyOrdsModel, alixyOrdsCell in
            alixyOrdsCell.ordsQuantityAly.text = alixyOrdsModel.ordsQuantityAly
            alixyOrdsCell.ordsAmountAly.text = alixyOrdsModel.ordsAmountAly
            alixyOrdsCell.alyButtonTouchBlock = { [weak self] in
                if let self = self {
                    self.mapEmotionFluctuationsToInsights(ordsIDAly: alixyOrdsModel.ordsIDAly,alixyUserSource:alixyOrdsModel.ordsQuantityAly)
                }
            }
        }
        .disposed(by: rx.disposeBag)
        
        if let ordsModel = createOrdsParams(ordsIDAly: "nabmsbusmzjuavdsa", ordsQuantityAly: AlixyHub.alixyInput("4j0q0"), ordsAmountAly: AlixyHub.alixyInput("0u.b9y9n$")) {
            alyOrdsParams.append(ordsModel)
        }
        
        
        if let ordsModel = createOrdsParams(ordsIDAly: "vnjokzkolwyfsutta", ordsQuantityAly: AlixyHub.alixyInput("8j0q0"), ordsAmountAly: AlixyHub.alixyInput("1u.b9y9n$")) {
            alyOrdsParams.append(ordsModel)
        }

        
        if let ordsModel = createOrdsParams(ordsIDAly: "zplxovkmuwnertyha", ordsQuantityAly: AlixyHub.alixyInput("1q2n0d0"), ordsAmountAly: AlixyHub.alixyInput("2u.b9y9n$")) {
            alyOrdsParams.append(ordsModel)
        }
        
        if let ordsModel = createOrdsParams(ordsIDAly: "ktrdnyldqxmcgowja", ordsQuantityAly: AlixyHub.alixyInput("2f4r5o0"), ordsAmountAly: AlixyHub.alixyInput("4u.b9y9n$")) {
            alyOrdsParams.append(ordsModel)
        }
        
        if let ordsModel = createOrdsParams(ordsIDAly: "iwvibsfbrqxszzopa", ordsQuantityAly: AlixyHub.alixyInput("4r9e0g0"), ordsAmountAly: AlixyHub.alixyInput("9u.b9y9n$")) {
            alyOrdsParams.append(ordsModel)
        }


        if let ordsModel = createOrdsParams(ordsIDAly: "fqrpceejzxoglycta", ordsQuantityAly: AlixyHub.alixyInput("9j8e0v0"), ordsAmountAly: AlixyHub.alixyInput("1q9c.j9r9x$")) {
            alyOrdsParams.append(ordsModel)
        }

        if let ordsModel = createOrdsParams(ordsIDAly: "bnqjdrxfcysavzhwa", ordsQuantityAly: AlixyHub.alixyInput("1p5j0q0v0"), ordsAmountAly: AlixyHub.alixyInput("2q9c.j9r9x$")) {
            alyOrdsParams.append(ordsModel)
        }

        if let ordsModel = createOrdsParams(ordsIDAly: "brrcjsskkqwvuoyka", ordsQuantityAly: AlixyHub.alixyInput("2e4b5v0q0"), ordsAmountAly: AlixyHub.alixyInput("4q9c.j9r9x$")) {
            alyOrdsParams.append(ordsModel)
        }

        if let ordsModel = createOrdsParams(ordsIDAly: "tghxpklewovjcrnua", ordsQuantityAly: AlixyHub.alixyInput("3d6q0v0q0"), ordsAmountAly: AlixyHub.alixyInput("6q9c.j9r9x$")) {
            alyOrdsParams.append(ordsModel)
        }

        if let ordsModel = createOrdsParams(ordsIDAly: "dmgwvfmnsqabvofda", ordsQuantityAly: AlixyHub.alixyInput("4o9l0s0g0"), ordsAmountAly: AlixyHub.alixyInput("9q9c.j9r9x$")) {
            alyOrdsParams.append(ordsModel)
        }
        
        ordsCollectionItems.onNext(alyOrdsParams)
    }
    
    func mapEmotionFluctuationsToInsights(ordsIDAly:String,alixyUserSource:String){
        MCToast.loadIng()
        
        
        SwiftyStoreKit.purchaseProduct(ordsIDAly, quantity: 1, atomically: true) { result in
            MCToast.dismis()
            switch result {
            case .success(_):
                
                self.botOrdsItems.append(200)
                if self.botOrdsItems.count > 0 {
                    self.botOrdsItems.insert(200, at: 0)
                }
                
                if var alixyRoverBot = try? AlixyHub.shared.alixyRoverBot.value() {
                    alixyRoverBot.botOrbs += Int(alixyUserSource)!
                    
                    AlixyHub.shared.alixyMmkv?.set(String(format: "%d", alixyRoverBot.botOrbs), forKey: alixyRoverBot.botCreaterId + "Orbs")
                    AlixyHub.shared.alixyRoverBot.onNext(alixyRoverBot)
                }
                
            case .error(let error):
                switch error.code {
                case .unknown:
//                    let errorAlyMessage = "Unknown error. Please contact support"
                    let errorAlyMessage = AlixyHub.alixyInput("Uqnjkgnroqweno getrxrmotrv.w mPdlueaacszez acuolnktuancrtt dsxurpspgobrwt")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .clientInvalid:
//                    print("Not allowed to make the payment")
                    let errorAlyMessage = AlixyHub.alixyInput("Nrobte varlslvojweeldp htxop smwajkkeq ttfhgew fpqaayomaeqnut")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .paymentCancelled:
                    let errorAlyMessage = AlixyHub.alixyInput("Pdacydmdeknjtw qCranncclejloeed")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .paymentInvalid:
//                    print("The purchase identifier was invalid")
                    let errorAlyMessage = AlixyHub.alixyInput("Tthgep jpiuprvcrhpatsnep jiudgernsthinfzieelrf twgamsa xicnqvrarliifd")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .paymentNotAllowed:
//                    print("The device is not allowed to make the payment")
                    let errorAlyMessage = AlixyHub.alixyInput("Tyhser vdpepvcilclec miksv xnzooto tavlalaoywbefdb stzoh wmtazkkef ftshveo yplabyamyepnst")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .storeProductNotAvailable:
                    //print("The product is not available in the current storefront")
                    let errorAlyMessage = AlixyHub.alixyInput("Tphwep xpfrqozdvuqcztz fiusr inyoztl waavzaeipleawbulaeh viyno atchzer fccuurlrtednotk ssutdorrpepftrjognjt")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .cloudServicePermissionDenied:
//                    print("Access to cloud service information is not allowed")
                    let errorAlyMessage = AlixyHub.alixyInput("Avcdcweesesh gtron qcplfokuzdq xszezrevniwcuey tijnwfxoaremcajtjibonno pilse nndostf zablallogwdevd")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .cloudServiceNetworkConnectionFailed:
//                    print("Could not connect to the network")
                    let errorAlyMessage = AlixyHub.alixyInput("Cjofuplqdd enaoytp kckoynjnnelcrtb xtbou mtyhsei knlevtowzobrkk")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                case .cloudServiceRevoked:
//                    print("User has revoked permission to use this cloud service")
                    let errorAlyMessage = AlixyHub.alixyInput("Umsjeqrn shiabsj yrredvcoekeeedv qpxedrsmxivsjskieobnj qtgoy qumsjeg xtnheipsl wcylqooupdm xseefrhvpibcue")
                    if errorAlyMessage.count > 0 {
                        MCToast.mc_text(errorAlyMessage)
                    }
                default:
//                    print((error as NSError).localizedDescription)
                    MCToast.mc_text((error as NSError).localizedDescription)
                }
            }
        }
        
//        AlixyHub.shared.mapEmotionFluctuationsToInsights(userID: ordsIDAly, alixyUserSource: "alixyUserSource") { alyParams in
//            MCToast.dismis()
//            if let alyFlag = alyParams["flag"] as? Bool{
//                if alyFlag == true {
//                    if var alixyRoverBot = try? AlixyHub.shared.alixyRoverBot.value() {
//                        alixyRoverBot.botOrbs += Int(alixyUserSource)!
//                        
//                        AlixyHub.shared.alixyMmkv?.set(String(format: "%d", alixyRoverBot.botOrbs), forKey: alixyRoverBot.botCreaterId + "Orbs")
//                        AlixyHub.shared.alixyRoverBot.onNext(alixyRoverBot)
//                    }
//                }else{
//                    MCToast.mc_text(alyParams["alyInfo"] as! String)
//                }
//            }
//        }
    }
    
    func ordsCollectionReset(itemSpacing:CGFloat){
        let interactiveCollectionLayout = UICollectionViewFlowLayout()
        var collectionItemSpacing = 0.0
        if itemSpacing > 0 {
            collectionItemSpacing = itemSpacing
            interactiveCollectionLayout.minimumInteritemSpacing = collectionItemSpacing
            interactiveCollectionLayout.minimumLineSpacing = collectionItemSpacing
            interactiveCollectionLayout.sectionInset = UIEdgeInsets(top: 16, left: 18, bottom: 18, right: 18)
            interactiveCollectionLayout.itemSize = CGSizeMake((self.view.bounds.size.width - 96)/3 , 158)
            ordsCollection.setCollectionViewLayout(interactiveCollectionLayout, animated: true)
        }
    }
    
    
    func createOrdsParams(ordsIDAly: String, ordsQuantityAly: String,ordsAmountAly: String) -> OrdsParams? {
        if let model = OrdsParams.deserialize(from: [
            "ordsIDAly":ordsIDAly,
            "ordsQuantityAly":ordsQuantityAly,
            "ordsAmountAly":ordsAmountAly]) {
            return model
        }
        return nil
    }

}



class AlixyBotOrdsCollectionViewCell:UICollectionViewCell {
    
    @IBOutlet weak var ordsQuantityAly: UILabel!
    @IBOutlet weak var ordsAmountAly: UILabel!
    
    
    var alyButtonTouchBlock:(()->())?
    
    @IBAction func rechargeInAlixy(_ sender: Any) {
        alyButtonTouchBlock?()
    }
}




