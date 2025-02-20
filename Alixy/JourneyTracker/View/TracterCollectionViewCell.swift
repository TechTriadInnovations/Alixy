//
//  TracterCollectionViewCell.swift
//  Alixy
//
//  Created by Alixy on 2024/12/20.
//

import UIKit
import SwifterSwift

class TracterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trackerFollowButton: UIButton!
    @IBOutlet weak var tracterImage: UIImageView!
    @IBOutlet weak var alixyUserImage: UIImageView!
    @IBOutlet weak var alixyUserName: UILabel!
    @IBOutlet weak var trackerDetail: UILabel!
    @IBOutlet weak var trackerContentView: UIView!
    
    var botCreaterImageTaped:(()->())?
    
    var reliefRoverBot:ReliefRoverBot!{
        didSet{
            tracterImage.image = .init(named: reliefRoverBot.trackerPics.first!)
            alixyUserImage.image = .init(named: reliefRoverBot.botCreaterId)
            alixyUserName.text = reliefRoverBot.botCreater
            trackerDetail.text = reliefRoverBot.trackerContent
            
            if AlixyHub.shared.alixyMmkv?.string(forKey: "alyFollowedCreater" + reliefRoverBot.botCreaterId) != nil {
                trackerFollowButton.isSelected = true
            }else{
                trackerFollowButton.isSelected = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trackerContentView.layerCornerRadius = 46
        trackerContentView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        tracterImage.layerCornerRadius = 46
        tracterImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        alixyUserImage.isUserInteractionEnabled = true
        alixyUserImage.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                if let self = self {
                    self.botCreaterImageTaped?()
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    @IBAction func trackerFollowInAlixy(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected == true {
            AlixyHub.shared.alixyMmkv?.set(reliefRoverBot.botCreaterId, forKey: "alyFollowedCreater" + reliefRoverBot.botCreaterId)
        }else{
            AlixyHub.shared.alixyMmkv?.removeValue(forKey: "alyFollowedCreater" + reliefRoverBot.botCreaterId)
        }
    }
    
}

