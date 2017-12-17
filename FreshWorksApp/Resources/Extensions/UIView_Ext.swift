//
//  UIView_Ext.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-15.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit

extension UIView {
    var activityIndicatorTag: Int { return 888888 }
    var overlayTag: Int { return 888888 }
    func addActivityIndicator(location:CGPoint, style: UIActivityIndicatorViewStyle) {
        removeActivityIndicator()
        DispatchQueue.main.async(execute: {
            
            //Create the activity indicator
            
            let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: style)
            //Add the tag so we can find the view in order to remove it later
            
            activityIndicator.tag = self.activityIndicatorTag
            //Set the location
            activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            activityIndicator.center = location
            activityIndicator.hidesWhenStopped = true
            //Start animating and add the view
            
            activityIndicator.startAnimating()
            self.addSubview(activityIndicator)
        })
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async(execute: {
            if let activityIndicator = self.subviews.filter(
                { $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        })
    }
}
