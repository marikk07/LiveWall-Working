//
//  CollectionViewController.swift
//  LiveWallpapers
//
//  Created by polat on 6/26/17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    

    var wallpaperData = [[String:String]]()

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        readFromPlist()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WallpaperCell", for: indexPath) as! CollectionViewCell
        let imageName = wallpaperData[indexPath.row]["fileName"]
        cell.wallpaperImageView.image = UIImage(named: "\(imageName!).JPG")
        return cell

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return wallpaperData.count
        
    }
    
    
    
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaults.standard.set(indexPath.row, forKey: "currentWallpaperNumber")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.size.width/2.0, height: UIScreen.main.bounds.size.height/2.4)
        
    }

    
    
    
    func readFromPlist(){
        if let plistPath = Bundle.main.path(forResource: "List", ofType: "plist") {
            var data:Data?
            let url = URL(fileURLWithPath: plistPath)
            do {
                data = try Data(contentsOf: url)
                print("data: \(data!)")
            } catch {
            }
            if data != nil {
                do {
                    let plist = try PropertyListSerialization.propertyList(from: data!, options: PropertyListSerialization.ReadOptions.mutableContainers, format: nil)
                    self.wallpaperData = plist as! [[String:String]]
                } catch {
                }
            }
        }
    }
    
    
    
    @IBAction func cancalBtnDidTap(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
}
