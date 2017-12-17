//
//  FWUIView.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-16.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit

class FWUIView: UIView {

    @IBOutlet var view: UIView!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        layoutIfNeeded()
        
    }
    
    func loadViewFromNib() -> UIView {
        return UIView()
    }
    
    func show() {
        
    }
    
    func hide() {
        
    }

}
