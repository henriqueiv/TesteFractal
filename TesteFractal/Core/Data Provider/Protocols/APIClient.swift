//
//  APIClient.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

enum APIError: Error {
    case unknown(String)
    case http(Error)
    case json(Error)
}

typealias ErrorCompletionBlock = (([Beer]?, APIError?) -> ())

protocol APIClient {
    func listBeers(ids: [Int]?, completion: ErrorCompletionBlock?)
}
