//
//  ImagePickerManager.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-15.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import Foundation
import AVFoundation
import MobileCoreServices
import Photos

enum ImagePickerType {
    case Camera, Library
}

protocol ImagePicked:class {
    func presentImages()
}

protocol ImagesInKeyChain:class {
    
}

extension ImagesInKeyChain {
    func loadImages() -> [Data] {
        var images:[Data] = []
        if let storedImages = KeyChainManager.load(key: "images"), let dictionary = NSKeyedUnarchiver.unarchiveObject(with: storedImages) as? [String : Any] {
            
            if let storedImages = dictionary["images"] as? [Data] {
                images.append(contentsOf: storedImages)
            }
        }
        return images
    }
    
    func saveImagesToKeyChain(_ images:[Data]) {
        KeyChainManager.save(key: "images", data: NSKeyedArchiver.archivedData(withRootObject: ["images":images]))
    }
    
    func saveImage(_ image: UIImage) {
        var images:[Data] = []
        let savedImages = loadImages()
        if savedImages.count > 0 {
            images.append(contentsOf: savedImages)
        }
        images.append(UIImageJPEGRepresentation(image, 1.0)!)
        
        saveImagesToKeyChain(images)
    }
    
    func deleteImageAt(index:Int) {
        var images = loadImages()
        guard images.count > 0 else {return}
        images.remove(at: index)
        saveImagesToKeyChain(images)
    }
}

final class ImagePickerManager: NSObject, UINavigationControllerDelegate, ImagesInKeyChain {
    
    weak var vc:ImagePickerViewController?
    
    var imagePicker:UIImagePickerController
    
    override init() {
        imagePicker = UIImagePickerController()
        super.init()
        self.setUpImagePicker()
    }
    
    func openImagePickerFor(vc:ImagePickerViewController) {
        self.vc = nil
        self.vc = vc
        showMenu()
    }
    
    fileprivate func showMenu() {
        DispatchQueue.main.async(execute: { () -> Void in
            let optionMenu:UIAlertController = UIAlertController()
            
            let takePhotoAction:UIAlertAction = UIAlertAction(title: Strings().takePhotoWithCameraTitle, style: .default, handler: { [weak self]
                (alert: UIAlertAction!) -> Void in
                guard let strongSelf = self else { return }
                strongSelf.openCamera()
            })
            
            let choosePhotoAction:UIAlertAction = UIAlertAction(title: Strings().choosePhotoFromLibraryTitle, style: .default, handler: { [weak self]
                (alert: UIAlertAction!) -> Void in
                guard let strongSelf = self else { return }
                strongSelf.openLibrary()
            })
            
            optionMenu.addAction(takePhotoAction)
            optionMenu.addAction(choosePhotoAction)
            
            let cancelAction:UIAlertAction = UIAlertAction(title: Strings().cancelTitle, style: .cancel, handler: {
                (alert: UIAlertAction) -> Void in
            })
            
            optionMenu.addAction(cancelAction)
            
            self.vc?.present(optionMenu, animated: true, completion: nil)
        })
    }
    
    //
    // MARK: - Action Methods
    //
    
    func openCamera() {
        guard self.authorizedFor(type: .Camera) else {
            vc?.alert(Strings().cameraNotAuthorized)
            return
        }
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imagePicker.sourceType = .camera
            vc?.present(self.imagePicker, animated: true, completion: nil)
        }
        else {
            vc?.alert(Strings().failToAccessCamera)
        }
    }
    
    func openLibrary() {
        guard self.authorizedFor(type: .Library) else {
            vc?.alert(Strings().libraryNotAuthorized)
            return
        }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            self.imagePicker.sourceType = .photoLibrary
            vc?.present(self.imagePicker, animated: true, completion: nil)
            return
        }
        else {
            vc?.alert(Strings().failToAccessLibrary)
        }
    }
    
    //
    // MARK: - Set up Methods
    //
    fileprivate func setUpImagePicker() {
        imagePicker.delegate = self
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = true
    }
    
    //
    //MARK: Check Authorization Methods / Closure
    //
    
    fileprivate func authorizedFor(type: ImagePickerType) -> Bool {
        switch type {
        case .Camera:
            return checkCameraAuthorizationStatus()
        case .Library:
            return checkPhotoLibraryAuthorizationStatus()
        }
    }
    
    fileprivate func checkCameraAuthorizationStatus() -> Bool {
        let status:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        guard status != .authorized, status != .notDetermined else {
            return true
        }
        return false
    }
    
    fileprivate func checkPhotoLibraryAuthorizationStatus() -> Bool {
        let status:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        guard status != .authorized, status != .notDetermined else {
            return true
        }
        return false
    }
    
    deinit {
        vc = nil
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate {
    func gotImage(image:UIImage) {
        saveImage(image)
        vc?.presentImages()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        vc?.dismiss(animated: true, completion: nil)
        guard let mediaType:NSString = info[UIImagePickerControllerMediaType] as? NSString else {
            return
        }
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                gotImage(image: image)
            }
            else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                gotImage(image: image)
            }
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.vc?.dismiss(animated: true, completion: nil)
    }
}

