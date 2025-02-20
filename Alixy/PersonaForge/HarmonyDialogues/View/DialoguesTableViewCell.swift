//
//  DialoguesTableViewCell.swift
//  Alixy
//
//  Created by Alixy on 2024/12/20.
//

import UIKit

class DialoguesTableViewCell: UITableViewCell {

    @IBOutlet weak var alyBotImage: UIImageView!
    @IBOutlet weak var alyBotName: UILabel!
    @IBOutlet weak var alyDialoguesInfo: UILabel!
    
    var dialoguesInfo:DialoguesInfo!{
        didSet {
            if dialoguesInfo.isBot == true {
                alyBotImage.image = .init(named: dialoguesInfo.remoteId + ".png")
                alyBotName.text = dialoguesInfo.remoteAlyName
                alyDialoguesInfo.text = dialoguesInfo.info
            }else{
                alyBotImage.image = .init(named: dialoguesInfo.remoteId)
                alyBotName.text = dialoguesInfo.remoteAlyName
                alyDialoguesInfo.text = dialoguesInfo.info
            }
            
        }
    }

}
