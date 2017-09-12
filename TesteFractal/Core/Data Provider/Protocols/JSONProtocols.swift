//
//  JSONProtocols.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

typealias JSON = [String:Any]

protocol JSONEncodable {
    func encode() -> JSON
}

protocol JSONDecodable {
    init(json: JSON)
}

typealias Serializable = (JSONEncodable & JSONDecodable)

