//
//  SideView.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0
    
    @IBInspectable
    var corners: UIRectCorner = [.topLeft, .bottomLeft]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        round(corners, radius: cornerRadius)
    }
}
