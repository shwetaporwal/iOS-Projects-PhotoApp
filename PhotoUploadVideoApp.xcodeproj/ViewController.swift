//
//  ViewController.swift
//  PhotoUploadVideoApp
//
//  Created by Shweta Porwal on 13/06/17.
//  Copyright © 2017 SAI APPS. All rights reserved.
//

import UIKit

import Photos
import BSImagePicker

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func addImagesClicked(_ sender: Any) {
        
        
      
        // create an instance
        let vc = BSImagePickerViewController()
        
        //display picture gallery
        self.bs_presentImagePickerController(vc, animated: true,
                                             select: { (asset: PHAsset) -> Void in
                                                
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets

            for i in 0..<assets.count
            {
                self.SelectedAssets.append(assets[i])
            
            }
            
            self.convertAssetToImages()
            
        }, completion: nil)
        
    }
    
    
    func convertAssetToImages() -> Void {
        
        if SelectedAssets.count != 0{
            
            
            for i in 0..<SelectedAssets.count{
                
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                
               
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                    
                })
                
                let data = UIImageJPEGRepresentation(thumbnail, 0.7)
                let newImage = UIImage(data: data!)
              
                
                self.PhotoArray.append(newImage! as UIImage)
                
            }
           
            self.imgView.animationImages = self.PhotoArray
            self.imgView.animationDuration = 3.0
            self.imgView.startAnimating()
            
        }
        
        
        print("complete photo array \(self.PhotoArray)")
    }
    
    
}

