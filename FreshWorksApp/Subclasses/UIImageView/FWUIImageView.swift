//
//  FWUIImageView.swift
//  FreshWorksApp
//
//  Created by Jordan  Romero Porter on 2017-12-16.
//  Copyright © 2017 FreshWorks. All rights reserved.
//

import UIKit
@IBDesignable
class FWUIImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.contentMode = .scaleAspectFit
    }

}
