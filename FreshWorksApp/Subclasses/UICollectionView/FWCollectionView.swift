//
//  FWCollectionView.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-15.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit

enum FlowLayoutType {
    case Grid, List
}

class FWCollectionView: FWUIView {
    
    var flowLayoutType:FlowLayoutType = .Grid
    
    fileprivate let listFlowLayout:ListFlowLayout = ListFlowLayout()
    fileprivate let gridFlowLayout:GridFlowLayout = GridFlowLayout()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func xibSetup() {
        super.xibSetup()
        collectionView.register(UINib(nibName: "ImageGridCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageGridCollectionViewCell")
        collectionView.register(UINib(nibName: "ImageListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageListCollectionViewCell")
    }
    
    override func loadViewFromNib() -> UIView {
        let nib:UINib = UINib(nibName: "FWCollectionView", bundle: Bundle(for: FWCollectionView.self))
        let view:UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func changeLayoutTo(_ flowLayout: FlowLayoutType) {
        self.flowLayoutType = flowLayout
        collectionView.reloadData()
        switch flowLayout {
        case .Grid:
            changeToGrid()
        case .List:
            changeToList()
        }
    }
    
    fileprivate func changeToList() {
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: false)
        }
    }
    
    fileprivate func changeToGrid() {
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: false)
        }
    }
}
