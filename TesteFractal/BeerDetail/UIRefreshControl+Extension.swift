//
//  UIRefreshControl+Extension.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 05/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation
import UIKit.UIRefreshControl

extension UIRefreshControl {
    func refreshManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: false)
        }
        beginRefreshing()
        sendActions(for: .valueChanged)
    }
}
