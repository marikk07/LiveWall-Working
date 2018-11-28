//
//  AppDelegate.swift
//  LiveWallpapers
//
//  Created by polat on 3/8/17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static let FolderName = "liveWallpapers"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupDirectory()
        setupAmazonS3()
        #if DEVELOP
        print("Develop Version")
        ShopManager.sharedInstance.completePurchase()
        #else
  

//        let isSubscribed = UserDefaults.standard.bool(forKey: Constants.UDsubscriptionEnable)
        
//        if isSubscribed {
//            ShopManager.sharedInstance.showMainScreen()
//            ShopManager.sharedInstance.completePurchase()
//        }
        
        #endif
        return true
    }

    private func setupAmazonS3() {
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USEast1, identityPoolId:"us-east-1:67023d5c-22df-4620-81ac-2b3cca4f7504")
        let configuration = AWSServiceConfiguration(region:.USEast1, credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
    }

    private func setupDirectory() {
        
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath =  tDocumentDirectory.appendingPathComponent("\(AppDelegate.FolderName)")
            if !fileManager.fileExists(atPath: filePath.path) {
                do {
                    try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Couldn't create document directory")
                }
            }
            print("Document directory is \(filePath)")
        }
    }
    
}

