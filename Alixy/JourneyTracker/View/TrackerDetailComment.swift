//
//  TrackerDetailComment.swift
//  Alixy
//
//  Created by Alixy on 2024/12/23.
//

import UIKit
import SVProgressHUD

class TrackerDetailComment: UIView {

    @IBOutlet weak var alixyFiledComment: UITextField!
    

    @IBAction func commentInAlixy(_ sender: Any) {
        alixyFiledComment.resignFirstResponder()
        DispatchQueue.main.async {
            MCToast.loadIng()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                MCToast.dismis()
                MCToast.mc_text(AlixyHub.alixyInput("Tchpaanpkt zyhohuz vfvotra gyvotuhre iczoymdmieznvtv,r awney kwjiclnlu drpemvpioegwa ribtc ratsl rsiodohno cavsn wpeodsasxiqbylke"))
                self.alixyFiledComment.text = nil
            }
        }
    }
}
