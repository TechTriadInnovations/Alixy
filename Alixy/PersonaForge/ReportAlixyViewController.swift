//
//  ReportAlixyViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import SVProgressHUD


class ReportAlixyViewController: StressReliefAccessViewController {
    
    
    @IBOutlet weak var typeAlyView1: UIView!
    @IBOutlet weak var typeAlyView2: UIView!
    @IBOutlet weak var typeAlyView3: UIView!
    @IBOutlet weak var typeAlyView4: UIView!
    @IBOutlet weak var typeAlyView5: UIView!
    
    @IBOutlet weak var falseInformationTxtView: UITextView!
    @IBOutlet weak var txtViewPlaceholder: UILabel!
    
    @IBOutlet weak var submitAlyButton: UIButton!
    let selectReportAlyType = BehaviorSubject<String?>(value: nil)
    
    var selectedTypeBackground:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitAlyButton.isEnabled = false
        falseInformationTxtView
            .rx.text
            .orEmpty
            .subscribe(onNext:{ [weak self] newAlyInput in
                if let self = self {
                    self.txtViewPlaceholder.isHidden = newAlyInput.count > 0
                }
            })
            .disposed(by: rx.disposeBag)
        
        selectReportAlyType
            .subscribe(onNext:{ [weak self] reportAlyType in
                if let self = self {
                    self.submitAlyButton.isEnabled = reportAlyType != nil
                }
            })
            .disposed(by: rx.disposeBag)
        
        alyReportTypeViewTaped(typeAlyView1)
        alyReportTypeViewTaped(typeAlyView2)
        alyReportTypeViewTaped(typeAlyView3)
        alyReportTypeViewTaped(typeAlyView4)
        alyReportTypeViewTaped(typeAlyView5)
    }
    
    func alyReportTypeViewTaped(_ typeAlyView:UIView){
        typeAlyView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext:{ [weak self] gestureAly in
                if let self = self {
                    if let gestureAlyViwe = gestureAly.view,let gestureAlyImage = self.view.viewWithTag(gestureAlyViwe.tag + 100) as? UIImageView{
                        if gestureAlyImage.isHidden == false {
                            return
                        }
                        gestureAlyImage.isHidden = false
                        self.selectedTypeBackground?.isHidden = true
                        self.selectedTypeBackground = gestureAlyImage
                        self.selectReportAlyType.onNext("gestureAlyImage")
                    }
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    @IBAction func submitInAlixy(_ sender: Any) {
        MCToast.loadIng()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            MCToast.dismis()
            MCToast.mc_text(AlixyHub.alixyInput("Rhetpzourits qSjuxclcbebsfsyfpuelwlcy"))
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
