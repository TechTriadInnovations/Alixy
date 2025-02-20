//
//  TracterDetailCollectionViewCell.swift
//  Alixy
//
//  Created by Alixy on 2024/12/20.
//

import UIKit
import RxGesture

class TracterDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var trackerImage: UIImageView!
    @IBOutlet weak var trackerUser: UIImageView!
    @IBOutlet weak var trankerUserName: UILabel!
    @IBOutlet weak var trackerInfo: UILabel!
    
    var botCreaterImageTaped:(()->())?
    
    var relieAlyBot:ReliefRoverBot!{
        didSet{
            trackerUser.image = .init(named: relieAlyBot.botCreaterId)
            trankerUserName.text = relieAlyBot.botCreater
            trackerInfo.text = relieAlyBot.trackerContent
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trackerUser.isUserInteractionEnabled = true
        trackerUser
            .rx.tapGesture()
            .when(.recognized)
            .subscribe { [weak self] _ in
                if let self = self {
                    self.botCreaterImageTaped?()
                }
            }
            .disposed(by: rx.disposeBag)
    }
}
