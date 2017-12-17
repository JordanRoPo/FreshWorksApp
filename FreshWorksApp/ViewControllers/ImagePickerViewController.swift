//
//  ImagePickerViewController.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-16.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController, ImagePicked {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentImages()
    }
    
    var images:[UIImage] = []
    func presentImages() {
        if let storedImages = KeyChainManager.load(key: "images"), let dictionary = NSKeyedUnarchiver.unarchiveObject(with: storedImages) as? [String : Any] {
            
            if let storedImages = dictionary["images"] as? [Data] {
                images.removeAll()
                for image in storedImages {
                    images.append(UIImage(data: image)!)
                }
            }
        }
    }
}
