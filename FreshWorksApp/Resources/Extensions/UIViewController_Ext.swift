//
//  UIViewController_Ext.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-15.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(_ message: String, title: String = "Oops", OKTitle:String = "Ok") {
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction:UIAlertAction = UIAlertAction(title: OKTitle, style: .default, handler: { [weak self] action in
            self?.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertDecision(_ title:String, message:String, decision: @escaping (Bool) -> Void) {
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction:UIAlertAction = UIAlertAction(title: "Yes", style: .cancel) { (action) in
            decision(true)
        }
        alertController.addAction(confirmAction)

        let exitAction:UIAlertAction = UIAlertAction(title: "No", style: .default) { (action) in
            decision(false)
        }
        alertController.addAction(exitAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
