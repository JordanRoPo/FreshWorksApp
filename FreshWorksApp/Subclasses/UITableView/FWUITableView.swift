//
//  FWUITableView.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-16.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit

class FWUITableView: FWUIView {

    @IBOutlet weak var tableView: UITableView!
    
    override func xibSetup() {
        super.xibSetup()
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70.0
    }
    
    override func loadViewFromNib() -> UIView {
        let nib:UINib = UINib(nibName: "FWUITableView", bundle: Bundle(for: FWUITableView.self))
        let view:UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}
