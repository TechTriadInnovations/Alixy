//
//  EmotionSculptingViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/24.
//

import UIKit
import PhotosUI
import SVProgressHUD
import RxSwift
import RxCocoa

class EmotionSculptingViewController: StressReliefAccessViewController,PHPickerViewControllerDelegate {

    var alyUploadBtn:UIButton!
    @IBOutlet weak var resultAliyImage: UIImageView!
    @IBOutlet weak var aliPlaceholder: UILabel!
    @IBOutlet weak var trackerInfo: UITextView!
    
    
    var alixyState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        trackerInfo
            .rx.text
            .orEmpty
            .subscribe { [weak self] trackerInfo in
                if let self = self {
                    self.aliPlaceholder.isHidden = trackerInfo.count > 0
                }
            }
            .disposed(by: rx.disposeBag)
    }
    
    @IBAction func alyUploadPicture(_ sender: Any) {
        self.alyUploadBtn = sender as? UIButton
        alixyCheckLibraryState()
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
    
    @IBAction func releaseAlyTrackerInAlixy(_ sender: Any) {
        
        if trackerInfo.text.count == 0 {
            MCToast.mc_text(AlixyHub.alixyInput("Cyognytdegnitm zciahnhnwodtd ablet pexmfpftcy"))
            return
        }
        
        MCToast.loadIng()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            MCToast.dismis()
            MCToast.mc_text(AlixyHub.alixyInput("Rbedlcesasssel xscumcncveeshszfnugla,a ywlez wwgiqllls wraemvtiyenwy iistd capss wsaorobnu gansa gpwosspswidbllhe"))
            self.navigationController?.popViewController()
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
                        self.resultAliyImage.image = resultImage
                        self.alyUploadBtn?.isHidden = true
                    }
                }
            }
        }
    }
    

}
