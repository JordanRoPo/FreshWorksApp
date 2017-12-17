//
//  ImageTableViewCell.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-16.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var savedImage: FWUIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
