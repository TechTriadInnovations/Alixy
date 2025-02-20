//
//  EmotionThroughDialogueController.swift
//  Alixy
//
//  Created by Alixy on 2024/12/25.
//

import UIKit
import AVFoundation
import SVProgressHUD

class EmotionThroughDialogueController: StressReliefAccessViewController {
    
    private var remoteAlySession: AVCaptureSession?
    var relieAlyBot:ReliefRoverBot?
    private var localAlyPreViewer: AVCaptureVideoPreviewLayer?
    
    private let alixyRemoteCreaterImage = UIImageView()
    private let alyLoadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
    private var callAlyTimer: Timer?
    private var callWaitTime = 10
    
    var alyCallState = (0,"CallWait","")
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        alixyRemoteCreaterImage.contentMode = .scaleAspectFill
        alixyRemoteCreaterImage.layer.masksToBounds = true
        self.view.addSubview(alixyRemoteCreaterImage)
        alixyRemoteCreaterImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        let buttonSize: CGFloat = 60
        let buttonSpacing: CGFloat = (self.view.bounds.size.width - 64 - (buttonSize * 4)) / 3
        let buttonYOffset: CGFloat = -71
        let initialXOffset: CGFloat = 34

        let callLoadItems = ["toggleAlyCamer", "openAlyVoice", "openAlyCamer", "hangeAlyup"]

        callLoadItems.enumerated().forEach { index, item in
            let buttonAlyItem = UIButton(type: .custom)
            buttonAlyItem.tag = 100 + index
            buttonAlyItem.setBackgroundImage(UIImage(named: item), for: .normal)
            
            if index == 1 {
                buttonAlyItem.setBackgroundImage(UIImage(named: "closeAlyVoice"), for: .selected)
            }else if index == 2 {
                buttonAlyItem.setBackgroundImage(UIImage(named: "closeAlyCamer"), for: .selected)
            }
            
            buttonAlyItem.addTarget(self, action: #selector(itemButtonSne(_:)), for: .touchUpInside)
            view.addSubview(buttonAlyItem)
            buttonAlyItem.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                buttonAlyItem.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: initialXOffset + ((buttonSize + buttonSpacing) * CGFloat(index))),
                buttonAlyItem.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: buttonYOffset),
                buttonAlyItem.widthAnchor.constraint(equalToConstant: buttonSize),
                buttonAlyItem.heightAnchor.constraint(equalToConstant: buttonSize)
            ])
        }
        
        alyCallState = (0,"callWait","load")
        
        let alyFilterButton = UIBarButtonItem(
            image: UIImage.botAlyFilter.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(alyFilterButtonInAlixy)
        )
        self.navigationItem.rightBarButtonItem = alyFilterButton
        
        alixyRemoteCreaterImage.image = UIImage(named: relieAlyBot!.botCreaterId)
        self.title = relieAlyBot!.botCreater
        
        
        alyLoadingIndicator.center = view.center
        view.addSubview(alyLoadingIndicator)
        alyLoadingIndicator.startAnimating()
        
        alyCamerAuthState()
    }
    
    @objc func alyFilterButtonInAlixy(){
        let filterAlyController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        var alyAcionTitle = AlixyHub.alixyInput("Rjewsuprocrmt")
        if alyAcionTitle.isEmpty == false {
            filterAlyController.addAction(UIAlertAction(title: alyAcionTitle, style: .default, handler: { action in
                let reportAlixyController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: ReportAlixyViewController.self)
                self.navigationController?.pushViewController(reportAlixyController!)
            }))
            
            alyAcionTitle = AlixyHub.alixyInput("Ahdbdf obwlpodckknlgijsht")
            
            if alyAcionTitle.isEmpty == false {
                filterAlyController.addAction(UIAlertAction(title: alyAcionTitle, style: .default, handler: { action in
                    MCToast.loadIng()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        MCToast.dismis()
                        if let relieAlyBot = self.relieAlyBot {
                            AlixyHub.shared.alixyMmkv?.set(relieAlyBot.botCreaterId, forKey: "alyBlockBotCreater" + relieAlyBot.botCreaterId)
                            NotificationCenter.default.post(name: NSNotification.Name("trackerListChanged"), object: nil)
                            NotificationCenter.default.post(name: NSNotification.Name("botAlyUpdate"), object: nil)
                            self.alyCloseCall()
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }))
                
                filterAlyController.addAction(UIAlertAction(title: AlixyHub.alixyInput("Cxaqnocherl"), style: .cancel, handler: nil))
                present(filterAlyController, animated: true, completion: nil)
            }
        }
    }
    
    func alyTimerStart(){
        callAlyTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(callTimeInAlixy), userInfo: nil, repeats: true)
        if callAlyTimer != nil {
            self.alyCallState = (1,"callIng","offer")
            RunLoop.current.add(callAlyTimer!, forMode: .common)
        }
    }
    
    func alyCloseCall() {
        callAlyTimer?.invalidate()
        callAlyTimer = nil
        remoteAlySession?.stopRunning()
        remoteAlySession?.inputs.forEach({[weak self] alyAVCaptureInput in
            if let self = self {
                self.remoteAlySession?.removeInput(alyAVCaptureInput)
            }
        })
        
        remoteAlySession?.outputs.forEach({ [weak self] alyAVCaptureOutput in
            if let self = self {
                self.remoteAlySession?.removeOutput(alyAVCaptureOutput)
            }
        })
        
        if self.alyCallState.0 < Int.random(in: 5...10) {
            localAlyPreViewer?.removeFromSuperlayer()
            localAlyPreViewer = nil
            remoteAlySession = nil
            if remoteAlySession == nil {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    
    func alyCamerAuthState() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            
            if self.alyCallState.1.count >= 0 {
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    if granted {
                        DispatchQueue.main.async { self?.switchCapSession() }
                    }
                }
            }
            
            
        case .authorized:
            if self.alyCallState.2.count >= 0 {
                switchCapSession()
            }
        default:
            break
        }
    }
    
    @objc func callTimeInAlixy(){
        callWaitTime -= 1
        if callWaitTime < 0 {
            MCToast.mc_text(AlixyHub.alixyInput("Tqhver godtmhceiru nuoswecrk nimsa znaocto ycxotnfnueecbtkefdi."))
            self.alyCloseCall()
        }
    }
    
    @objc private func itemButtonSne(_ sender: UIButton) {
        
        if alyCallState.0 > -1 {
            let clickIndex = sender.tag - 200
            switch clickIndex {
            case 0:
                if alyCallState.1.count >= 0 {
                    switchAlyCamer()
                }
                
            case 1:
                if alyCallState.1.count >= 0 {
                    sender.isSelected.toggle()
                    closeVoice(close: sender.isSelected)
                }
                
            case 2:
                
                if alyCallState.2.count >= 0 {
                    sender.isSelected.toggle()
                    closeAlyPreview(close: sender.isSelected)
                }
                
                
            case 3:
                if alyCallState.2.count >= 0 {
                    alyCloseCall()
                }
                
            default:
                break
            }
        }
        
        
    }
    
    func switchAlyCamer() {
        if let session = remoteAlySession {
            session.beginConfiguration()
            defer { session.commitConfiguration() }
            
            if self.alyCallState.1.count >= 0 ,let currentInput = session.inputs.first as? AVCaptureDeviceInput{
                let currentPosition = currentInput.device.position
                session.removeInput(currentInput)
                
                let newPosition: AVCaptureDevice.Position = (currentPosition == .back) ? .front : .back
                guard let newDevice = getAlyDeviceCamer(with: newPosition,flag: 10),let newInput = try? AVCaptureDeviceInput(device: newDevice) else { return }
                
                if session.canAddInput(newInput) && self.alyCallState.2.count >= 0{
                    session.addInput(newInput)
                }
            }
            
        }
        
    }
    
    func getAlyDeviceCamer(with position: AVCaptureDevice.Position,flag:Int) -> AVCaptureDevice? {
        if flag > 0 {
            return AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: position).devices.first
        }else {
            return nil
        }
    }
    
    func closeAlyPreview(close: Bool) {
        if close == false {
            guard let session = remoteAlySession,
                  let device = AVCaptureDevice.default(for: .video),
                  let input = try? AVCaptureDeviceInput(device: device) else { return }
            if session.canAddInput(input) {
                session.addInput(input)
            }
        } else {
            localAlyPreViewer?.isHidden = false
            remoteAlySession?.inputs.forEach({ [weak self] alyAVCaptureInput in
                if let self = self {
                    self.remoteAlySession?.removeInput(alyAVCaptureInput)
                }
            })
            localAlyPreViewer?.isHidden = true
        }
    }
    
    func seeMyPreViewer() {
        var cornerRadius = 0.0
        if localAlyPreViewer == nil {
            cornerRadius = 16.0
            localAlyPreViewer = AVCaptureVideoPreviewLayer(session: remoteAlySession!)
            localAlyPreViewer?.videoGravity = .resizeAspectFill
           
            localAlyPreViewer?.frame = CGRect(x: UIScreen.main.bounds.width - 160,y: UIScreen.main.bounds.height - 234 - 199,width: 140,height: 199)
            view.layer.addSublayer(localAlyPreViewer!)
            
            localAlyPreViewer?.cornerRadius = cornerRadius
            localAlyPreViewer?.masksToBounds = true
            
            
            if cornerRadius > 0 {
                DispatchQueue.global().async {
                    self.remoteAlySession?.startRunning()
                }
                self.alyTimerStart()
            }
        }
        
    }
    
    func closeVoice(close: Bool) {
        if let session = remoteAlySession {
            if close == false {
                guard let device = AVCaptureDevice.default(for: .audio),let input = try? AVCaptureDeviceInput(device: device) else { return }
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
            } else {
                session.inputs.compactMap { $0 as? AVCaptureDeviceInput }.filter { $0.device.hasMediaType(.audio) }.forEach { session.removeInput($0) }
            }
        }
        
    }
    
    func switchCapSession() {
        if remoteAlySession == nil {
            remoteAlySession = AVCaptureSession()
            remoteAlySession?.sessionPreset = .high
            
            if self.alyCallState.0 < 10 && remoteAlySession != nil {
                guard let frontCamera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first,
                      let input = try? AVCaptureDeviceInput(device: frontCamera),
                      remoteAlySession?.canAddInput(input) == true else { return }
                
                remoteAlySession?.addInput(input)
                seeMyPreViewer()
            }
        }
        
    }
    
    
}
