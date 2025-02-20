//
//  DialoguesBotLocalTableViewCell.swift
//  Alixy
//
//  Created by Alixy on 2024/12/24.
//

import UIKit

class DialoguesBotLocalTableViewCell: UITableViewCell {
    @IBOutlet weak var dialogInfo: UILabel!
    @IBOutlet weak var infoContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        infoContainer.layerCornerRadius = 30
        infoContainer.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner]
    }

}

class DialoguesBotRemoteTableViewCell: UITableViewCell {
    @IBOutlet weak var dialogInfo: UILabel!
    @IBOutlet weak var infoCintainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        infoCintainer.layerCornerRadius = 30
        infoCintainer.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
    }


}

