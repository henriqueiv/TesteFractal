//
//  Image.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 05/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation
import UIKit.UIImage

enum Image: String {
    case sad
    case heart
    case heartFilled
    
    var instance: UIImage {
        return UIImage(named: rawValue)!
    }
}

