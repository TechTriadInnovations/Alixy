//
//  MoodTrackerViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/25.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD

class MoodTrackerViewController: StressReliefAccessViewController {
    
    
    @IBOutlet weak var moodTrackerTxtView: UITextView!
    @IBOutlet weak var moodTrackerPlacehjolder: UILabel!
    
    @IBOutlet weak var alySubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = AlixyHub.alixyInput("Fmefewdkbsaycok")
        alySubmit.isEnabled = true
        moodTrackerTxtView.rx
            .text
            .orEmpty
            .subscribe(onNext:{ [weak self] alyTxt in
                if let self = self {
                    self.moodTrackerPlacehjolder.isHidden = alyTxt.count > 0
                    self.alySubmit.isEnabled = alyTxt.count > 0
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    @IBAction func submitInAlixy(_ sender: Any) {
        
        
        MCToast.loadIng()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            MCToast.dismis()
            MCToast.mc_text(AlixyHub.alixyInput("Wxez ahgakvsei yrgelcueyipvheedw cyqoouirq lfsehevdqbbaicckx,e xtwhbakncku nycovuu!"))
            self.navigationController?.popViewController()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
