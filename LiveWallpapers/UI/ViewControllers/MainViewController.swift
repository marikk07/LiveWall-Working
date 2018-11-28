//
//  ViewController.swift
//  LiveWallpapers
//
//  Created by polat on 3/8/17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import GoogleMobileAds
import AWSS3


final class MainViewController: UIViewController, GADInterstitialDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var saveBtn: UIButton! {
        didSet {
            saveBtn.imageView?.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var wallpaperImageView: UIImageView!
    @IBOutlet weak var loaderView: UIVisualEffectView!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Properties
    
    var wallpaper: Wallpaper!
    
    var wallpaperData = [[String:String]]()
    var currentWallpaperNumber = 0
    var looper: Looper?
    var playerLooper: NSObject?
    var playerLayer: AVPlayerLayer!
    var queuePlayer: AVQueuePlayer?
    var interstitial: GADInterstitial?

    private var stopTask: Bool?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        readFromPlist()
        loaderView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        looper?.stop()
        currentWallpaperNumber = UserDefaults.standard.integer(forKey: "currentWallpaperNumber")
        wallpaperImageView.image = wallpaper.image
        playVideoInLoop()
    }
    
    deinit {
        
    }
    
    // MARK: - IBActions
    
    @IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
//        showWallpaper(isNext: true)
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
//        showWallpaper(isNext: false)
    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
        stopTask = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnDidTap(_ sender: UIButton) {
        // Get the current authorization state.
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            self.saveToPhotoLibrary()
        }
            
        else if (status == PHAuthorizationStatus.denied) {
            // Access has been denied.
        }
        else if (status == PHAuthorizationStatus.notDetermined) {
            
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    self.saveToPhotoLibrary()
                } else {
                    
                }
            })
        }
            
        else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
        }
    }
    
    // MARK: - Private Methods
    
    func playVideoInLoop() {
        looper?.stop()
//        guard let videoName = wallpaperData[currentWallpaperNumber]["fileName"] else { return }
        let videoName = wallpaper.name
        guard let videoURL = getFilePath(fileName: videoName) else {
            downloadData()
            return
        }
        loaderView.isHidden = true

        looper = PlayerLooper(videoURL: videoURL, loopCount: 0)
        looper?.start(in: view.layer)
        view.bringSubview(toFront: saveBtn)
        view.bringSubview(toFront: closeButton)
        view.bringSubview(toFront: loaderView)
    }
    
    private func getFilePath(fileName: String) -> URL? {
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath =  tDocumentDirectory.appendingPathComponent("\(AppDelegate.FolderName)/\(fileName).MOV")
            if !fileManager.fileExists(atPath: filePath.path) {
                return nil
            }
            return filePath
        }
        return nil
    }
    
    private func downloadData() {
//        guard let videoName = wallpaperData[currentWallpaperNumber]["fileName"] else { return }
        let videoName = wallpaper.name
        loaderView.isHidden = false
        let expression = AWSS3TransferUtilityDownloadExpression()
        expression.progressBlock = {(task, progress) in
            DispatchQueue.main.async(execute: { [weak self] in
                if let stopTask = self?.stopTask {
                    task.cancel()
                }
                print(progress.completedUnitCount)
            // Do something e.g. Update a progress bar.
            })
        }
        
        var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
        completionHandler = { [weak self] (task, URL, data, error) -> Void in
            DispatchQueue.main.async(execute: {
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self?.saveVideoToDocuments(data: data, videoName: videoName)
            })
        }
        
        let transferUtility = AWSS3TransferUtility.default()
        transferUtility.downloadData(fromBucket: "com.codex.livewall", key: "\(videoName).MOV", expression: expression, completionHandler: completionHandler).continueWith { (task) -> Any? in
            if let error = task.error {
                print("Error: \(error.localizedDescription)")
            }
            if let _ = task.result {
                    // Do something with downloadTask.
            }
            return nil
        }
    }
    
    private func saveVideoToDocuments(data: Data?, videoName: String) {
        guard let videoData = data else {
            return
        }
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath =  tDocumentDirectory.appendingPathComponent("\(AppDelegate.FolderName)/\(videoName).MOV")
            if !fileManager.fileExists(atPath: filePath.path) {
                do {
                    try videoData.write(to: filePath)
                    playVideoInLoop()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Save & share
    
    private func saveToPhotoLibrary() {
        //        guard let fileName = wallpaperData[currentWallpaperNumber]["fileName"] else { return }
        let fileName = wallpaper.name
        guard let videoURL = getFilePath(fileName: fileName) else { return }
        let pathImage = Bundle.main.path(forResource: fileName, ofType: "JPG")
        let imageURl = URL(fileURLWithPath: pathImage!)
        
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetCreationRequest.forAsset()
            request.addResource(with: .photo, fileURL: imageURl, options: nil)
            request.addResource(with: .pairedVideo, fileURL: videoURL, options: nil)
        }) { (success, error) in
            if success == true {
                let alertController = UIAlertController(title: "SUCCESS", message: "Live Photo is successfully saved to photo library", preferredStyle: UIAlertControllerStyle.alert)
                let okayAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler:nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
            }
            print(success)
            print(error?.localizedDescription ?? "error")
        }
    }
    
    
//    private func showWallpaper(isNext: Bool) {
//        looper?.stop()
//        if isNext {
//            currentWallpaperNumber += 1
//            if currentWallpaperNumber > wallpaperData.count - 1 {
//                currentWallpaperNumber = 0
//            }
//        } else {
//            currentWallpaperNumber -= 1
//            if currentWallpaperNumber < 0 {
//                currentWallpaperNumber = wallpaperData.count - 1
//            }
//        }
//        UserDefaults.standard.set(currentWallpaperNumber, forKey: "currentWallpaperNumber")
//        let imageName = wallpaperData[currentWallpaperNumber]["fileName"]
//        self.wallpaperImageView.image = UIImage(named: "\(imageName!).JPG")
//        isNext ? self.wallpaperImageView.slideInFromRight() : self.wallpaperImageView.slideInFromLeft()
//        self.perform(#selector(MainViewController.playVideoInLoop), with: nil, afterDelay: 0.5)
//    }
//
//    private func readFromPlist() {
//        if let plistPath = Bundle.main.path(forResource: "List", ofType: "plist") {
//            var data:Data?
//            let url = URL(fileURLWithPath: plistPath)
//            do {
//                data = try Data(contentsOf: url)
//            } catch {
//            }
//            if data != nil {
//                do {
//                    let plist = try PropertyListSerialization.propertyList(from: data!, options: PropertyListSerialization.ReadOptions.mutableContainers, format: nil)
//                    self.wallpaperData = plist as! [[String:String]]
//                } catch {
//                }
//            }
//        }
//    }
//
//
    
//    func assignCurrentWallpaper() {
////        let imageName = wallpaperData[currentWallpaperNumber]["fileName"]
//        self.wallpaperImageView.image = wallpaper.image
//    }
    
    //Advertisement
    
    /*func loadAdmobBanner(){
        bannerView.adUnitID = ADMOB_BANNER_UNIT_ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
     private func bounce(view: UIView?) {
     view?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
     UIView.animate(withDuration: 0.6,
     delay: 0,
     usingSpringWithDamping: 1.0,
     initialSpringVelocity: 1.0,
     options: [.allowUserInteraction, .beginFromCurrentState, .autoreverse, .repeat],
     animations: {
     view?.transform = .identity
     },
     completion: nil)
     
     }
    
    func loadAdmobInterstitials(){
        interstitial = GADInterstitial(adUnitID: ADMOB_INTERSTITIALS_UNIT_ID)
        interstitial?.delegate = self
        interstitial?.load(GADRequest())
    }
    
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if ad.isReady {
            ad.present(fromRootViewController: self)
        }
    }*/
    
}
