//
//  CardView.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 05/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation
import UIKit.UIView

@IBDesignable
final class CardView: UIView {
    override func awakeFromNib() {
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.25
        layer.cornerRadius = 5
        layer.masksToBounds = false
        clipsToBounds = false
    }
}
