//
//  Array+Extension.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 05/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    public func joined(separator: String = "") -> String {
        return map { String($0) }.joined(separator: separator)
    }
}
