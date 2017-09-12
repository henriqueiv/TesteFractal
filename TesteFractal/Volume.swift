//
//  Volume.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

enum Volume: JSONDecodable {
    case liter(Float)
    
    init(json: JSON) {
        guard let unit = json["unit"] as? String, let value = json["value"] as? Float else {
            fatalError("Some required value missing")
        }
        
        self = Volume(unit: unit, value: value)
    }
    
    private init(unit: String, value: Float) {
        switch unit {
        case "liters":
            self = .liter(value)
        default:
            fatalError("Invalid unit \(unit)")
        }
    }
}

extension Volume: Equatable { }

func ==(lhs: Volume, rhs: Volume) -> Bool {
    switch (lhs, rhs) {
    case (.liter(let x), .liter(let y)):
        return x == y
    }
}

