//
//  PersonaForgeViewController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/18.
//

import UIKit
import SVProgressHUD
import PhotosUI
import RxGesture

class PersonaForgeViewController: StressReliefAccessViewController,UIScrollViewDelegate,PHPickerViewControllerDelegate {

    let axyAppearance = UINavigationBarAppearance()
    @IBOutlet weak var resultAliyImage: UIImageView!
    @IBOutlet weak var alixyFieldName: UITextField!
    
    @IBOutlet weak var introductionTxtView: UITextView!
    @IBOutlet weak var introductionPlaceHolder: UILabel!
    
    @IBOutlet weak var chatStyleTxtView: UITextView!
    @IBOutlet weak var chatStylePlaceHolder: UILabel!
    @IBOutlet weak var createAlyInfo: UIImageView!
    
    var alixyState = 0
    
    var alyUploadBtn:UIButton?
    
    var alixyNameBot = ""
    
    var alixyIntroduction = ""
    
    var alixyChatStyle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        axyAppearance.configureWithTransparentBackground()
        axyAppearance.backgroundColor = UIColor.init(hexString: "#121315",transparency: 0)
        
        navigationController?.navigationBar.standardAppearance = axyAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = axyAppearance
        navigationController?.navigationBar.compactAppearance = axyAppearance
        
        
        alixyFieldName
            .rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] fileName in
                if let self = self {
                    self.alixyNameBot = fileName
                }
            })
            .disposed(by: rx.disposeBag)
        
        introductionTxtView
            .rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] fileName in
                if let self = self {
                    self.alixyIntroduction = fileName
                    self.introductionPlaceHolder.isHidden = !fileName.isEmpty
                }
            })
            .disposed(by: rx.disposeBag)
        
        chatStyleTxtView
            .rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] fileName in
                if let self = self {
                    self.alixyChatStyle = fileName
                    self.chatStylePlaceHolder.isHidden = !fileName.isEmpty
                }
            })
            .disposed(by: rx.disposeBag)
        
    }
    
    @IBAction func alyUploadPicture(_ sender: Any) {
        self.alyUploadBtn = sender as? UIButton
        alixyCheckLibraryState()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        axyAppearance.backgroundColor = UIColor.init(hexString: "#121315",transparency: scrollView.contentOffset.y / 200)
        navigationController?.navigationBar.standardAppearance = axyAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = axyAppearance
    }

    @IBAction func createInAlixy(_ sender: Any) {
        if self.alixyNameBot.count == 0 ||
            self.alixyIntroduction.count == 0 ||
            self.alixyChatStyle.count == 0{
            MCToast.mc_text(AlixyHub.alixyInput("Pplseyaxsgez sfiinliln vicnd xtrhqew siinhfpouramdasteizoxnc ucvotmwpelyectpexlzy"))
            return
        }
        
        MCToast.loadIng()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            MCToast.dismis()
            MCToast.mc_text(AlixyHub.alixyInput("Wdes dheasvwek jrbedcberilvseidm gybovuprn yrseyqouzehsztf iaxnedy iwyislxlc qpfrjovceenswst aiwtx maysx qsgodotnc raxst zplopsusrizbfleel,p uphlxezafsoeh iwmaoidtg!"))
            self.navigationController?.popViewController()
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
                        self.resultAliyImage.image = resultImage
                        self.alyUploadBtn?.isHidden = true
                        self.createAlyInfo.isHidden = true
                    }
                }
            }
        }
    }
}
