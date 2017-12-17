//
//  SecondViewController.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-15.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit

class SecondViewController: ImagePickerViewController, UIGestureRecognizerDelegate, ImagesInKeyChain {
    
    @IBOutlet weak var cv: FWCollectionView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex  {
        case 0:
            cv.changeLayoutTo(.Grid)
        case 1:
            cv.changeLayoutTo(.List)
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cv.collectionView.delegate = self
        cv.collectionView.dataSource = self
        cv.changeLayoutTo(.Grid)
        presentImages()
        addLongGesture()
    }
    
    override func presentImages() {
        super.presentImages()
        cv.collectionView.reloadData()
    }
    
    func addLongGesture() {
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.cv.collectionView.addGestureRecognizer(lpgr)
    }
    //func pressedLongGest {
    @objc func handleLongPress(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizerState.began {
            let p = sender.location(in: cv.collectionView)
            let indexPath = cv.collectionView.indexPathForItem(at: p)
            
            if let index = indexPath {
                alertDecision("Delete", message: "Are you sure you want to delete this image?", decision: { [weak self] (yes) in
                    guard let strongSelf = self else {return}
                    if yes {
                        strongSelf.deleteImageAt(index: index.row)
                        strongSelf.images.remove(at: index.row)
                        strongSelf.cv.collectionView.performBatchUpdates({
                            strongSelf.cv.collectionView.deleteItems(at: [index])
                        }, completion: nil)
                    }
                })
                print(index.row)
            }
            else {
                self.alert("Having a problem trying to delete a cell.")
            }
        }
    }

    deinit {
        
    }


}

extension SecondViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cv.flowLayoutType {
        case .Grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageGridCollectionViewCell", for: indexPath) as! ImageGridCollectionViewCell
            cell.savedImage.image = images[indexPath.row]
            return cell
        case .List:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageListCollectionViewCell", for: indexPath) as! ImageListCollectionViewCell
            cell.savedImage.image = images[indexPath.row]
            return cell
            
        }
    }
    
}
