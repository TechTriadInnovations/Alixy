//
//  InteractiveHavenCollectionViewCell.swift
//  Alixy
//
//  Created by Alixy on 2024/12/20.
//

import UIKit
import RxGesture

class InteractiveHavenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var alixyUserBackgroundView: UIView!
    
    @IBOutlet weak var botImage: UIImageView!
    @IBOutlet weak var botCreaterImage: UIImageView!
    @IBOutlet weak var borCreaterName: UILabel!
    @IBOutlet weak var botSeeCount: UIButton!
    @IBOutlet weak var botCollectCount: UIButton!
    
    var botCreaterImageTaped:(()->())?
    
    var reliefReverBot:ReliefRoverBot!{
        didSet{
            botImage.image = .init(named: reliefReverBot.botPic)
            botCreaterImage.image = .init(named: reliefReverBot.botCreaterId)
            borCreaterName.text = reliefReverBot.botCreater
            botSeeCount.setTitle("  \(reliefReverBot.botSeeCount)", for: .normal)
            botCollectCount.setTitle("  \(reliefReverBot.botCollectCount)", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        alixyUserBackgroundView.isUserInteractionEnabled = true
        alixyUserBackgroundView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                if let self = self {
                    self.botCreaterImageTaped?()
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
}
