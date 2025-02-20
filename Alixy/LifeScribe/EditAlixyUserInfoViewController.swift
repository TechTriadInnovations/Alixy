//
//  EditAlixyUserInfoViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/25.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
import RxGesture
import PhotosUI
import BRPickerView

class EditAlixyUserInfoViewController: StressReliefAccessViewController,PHPickerViewControllerDelegate {
    
    var resultAlyImage:UIImage?
    
    @IBOutlet weak var userAlyAvatar: UIImageView!
    @IBOutlet weak var userAlyNameField: UITextField!
    @IBOutlet weak var userAlyGender: UILabel!
    @IBOutlet weak var userAlyBarthday: UILabel!
    @IBOutlet weak var userAlyInfoTextView: UITextView!
    @IBOutlet weak var infoPlaceholder: UILabel!
    @IBOutlet weak var genderAlyView: UIView!
    @IBOutlet weak var birthdayAlyView: UIView!
    
    var alixyState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = AlixyHub.alixyInput("Eddwiet")
        
        userAlyInfoTextView
            .rx.text.orEmpty
            .subscribe(onNext: { [weak self] info in
                if let self = self {
                    self.infoPlaceholder.isHidden = info.count > 0
                }
            })
            .disposed(by: rx.disposeBag)
        
        
        AlixyHub.shared.alixyRoverBot
            .subscribe(onNext: { alyBot in
                if let relieAlyBot = alyBot {
                    if let alyCacheImage = relieAlyBot.traclerCacheImaeg {
                        self.userAlyAvatar.image = alyCacheImage
                    }else{
                        self.userAlyAvatar.image = .init(named: relieAlyBot.botCreaterId)
                    }
                    self.userAlyNameField.text = relieAlyBot.botCreater
                    self.userAlyGender.text = relieAlyBot.trackerGender
                    self.userAlyBarthday.text = relieAlyBot.trackerBirthday
                    self.userAlyInfoTextView.text = relieAlyBot.botCreaterBio
                }
            })
            .disposed(by: rx.disposeBag)
        
        userAlyAvatar.isUserInteractionEnabled = true
        userAlyAvatar.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                if let self = self {
                    self.alixyCheckLibraryState()
                }
            })
            .disposed(by: rx.disposeBag)
        
        genderAlyView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe (onNext:{ [weak self] _ in
                if let self = self {
                    self.showAlyGender()
                }
            })
            .disposed(by: rx.disposeBag)
        
        birthdayAlyView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                if let self = self {
                    self.showAlyBirthday()
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    func showAlyGender(){
        let genderAlyPickerView = BRTextPickerView(pickerMode: .componentSingle)
        genderAlyPickerView.dataSourceArr = [AlixyHub.alixyInput("Fgeomyaqlee"),AlixyHub.alixyInput("Maawlce")]
        
        let customStyle = BRPickerStyle()
        customStyle.pickerColor = UIColor(red: 0xd9 / 255.0, green: 0xdb / 255.0, blue: 0xdf / 255.0, alpha: 1.0)
        customStyle.pickerTextColor = UIColor.init(hexString: "#354604")
        customStyle.separatorColor = UIColor.init(hexString: "#B3B4B1")
        genderAlyPickerView.pickerStyle = customStyle
        
        genderAlyPickerView.singleResultBlock = { [weak self] (model, index) in
            guard let self = self else { return }
            if let model = model {
                self.userAlyGender.text = model.text
            }
        }
        genderAlyPickerView.show()
    }
    
    func showAlyBirthday(){

        // 1. 创建日期选择器
        let datePickerView = BRDatePickerView()

        // 2. 设置属性
        datePickerView.pickerMode = .YMD
        datePickerView.minDate = createAlixyDate(year: 2006, month: 1, day: 1)
        datePickerView.maxDate = Date()
        datePickerView.resultBlock = { [weak self] selectDate, selectValue in
            if let self = self , let selectValue = selectValue {
                self.userAlyBarthday.text = selectValue
            }
        }

        let customStyle = BRPickerStyle()
        customStyle.pickerColor = UIColor(red: 0xd9 / 255.0, green: 0xdb / 255.0, blue: 0xdf / 255.0, alpha: 1.0)
        customStyle.pickerTextColor = UIColor.init(hexString: "#354604")
        customStyle.separatorColor = UIColor.init(hexString: "#B3B4B1")
        datePickerView.pickerStyle = customStyle

        datePickerView.show()
    }
    
    @IBAction func saveChangeStoreInAlixy(_ sender: Any) {
        
        MCToast.loadIng()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            MCToast.dismis()
            
            MCToast.mc_text(AlixyHub.alixyInput("Mloddjiwfpitclawtpigoanp zseuicrcaezshsifdurl"))
            if var alixyRoverBot = try? AlixyHub.shared.alixyRoverBot.value() {
                if let resultAlyImage = self.resultAlyImage {
                    alixyRoverBot.traclerCacheImaeg = resultAlyImage
                }
                
                if self.userAlyNameField.text?.count ?? 0 > 0 {
                    alixyRoverBot.botCreater = self.userAlyNameField.text!
                }
                
                alixyRoverBot.trackerGender = self.userAlyGender.text!
                alixyRoverBot.trackerBirthday = self.userAlyBarthday.text!
                
                if self.userAlyInfoTextView.text.count > 0 {
                    alixyRoverBot.botCreaterBio = self.userAlyInfoTextView.text!
                }
                
                AlixyHub.shared.alixyRoverBot.onNext(alixyRoverBot)
                self.navigationController?.popViewController()
            }
        }
        
        
    }
    
    func alixyCheckLibraryState() {
        let alyState = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch alyState {
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newState in
                
                if newState == .authorized {
                    self.alixyOpenPicLibrary()
                }
            }
                
        case .restricted, .denied:
            MCToast.mc_text(AlixyHub.alixyInput("Pxlpelaasbei zeondaibbloee gpkheortiox glaieberwatrnyo yaqcycyeosjss yianm qsxedtytqicnigise htyod lsxemlieicetx kpdhnoqtpozs"))
            
        case .authorized, .limited:
            self.alixyOpenPicLibrary()
        
        
        @unknown default:break
        }
    }
    
    
    func alixyOpenPicLibrary() {
        
        DispatchQueue.main.async {
            if self.alixyState == 0 {
                self.alixyState = 1
            }
            
            var pHPickerConfig = PHPickerConfiguration()
            pHPickerConfig.selectionLimit = self.alixyState
            pHPickerConfig.filter = .images
            if self.alixyState > 0 {
                let pHPicker = PHPickerViewController(configuration: pHPickerConfig)
                self.alixyState = self.alixyState * 10
                pHPicker.delegate = self
                
                if self.alixyState >= 10 {
                    self.alixyState = self.alixyState * 10
                }
                self.present(pHPicker, animated: true)
            }
        }
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true, completion: nil)
        
        if let picketResult = results.first {
            picketResult.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                guard let self = self else {return}
                if let resultImage = image as? UIImage {
                    DispatchQueue.main.async {
                        self.resultAlyImage = resultImage
                        self.userAlyAvatar.image = resultImage
                    }
                }
            }
        }
    }
    
    func createAlixyDate(year: Int, month: Int, day: Int, timeZone: TimeZone? = TimeZone.current) -> Date? {
        var alyDate:Date?
        if year > 0 {
            var dateComponents = DateComponents()
            dateComponents.year = year
            if month > 0 {
                dateComponents.month = month
            }
            if day > 0 {
                dateComponents.day = day
                
                var calendar = Calendar.current
                if let alyZone = timeZone {
                    calendar.timeZone = alyZone
                }
                alyDate = calendar.date(from: dateComponents)
            }
            
        }
        
        return alyDate
    }
    
    

}
