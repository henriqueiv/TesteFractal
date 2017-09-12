//
//  StubAPI.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

final class StubAPI: APIClient {
    
    func listBeers(ids: [Int]?, completion: ErrorCompletionBlock?) {
        let stubJsonFileName = "StubData"
        guard let fileUrl = Bundle.main.url(forResource: stubJsonFileName, withExtension: "json") else {
            fatalError("File \(stubJsonFileName).json not find in the main bundle")
        }
        
        do {
            let fileData = try Data(contentsOf: fileUrl)
            if let beersJson = try JSONSerialization.jsonObject(with: fileData, options: JSONSerialization.ReadingOptions.allowFragments) as? [JSON] {
                var beers = beersJson.map({ Beer(json: $0) })
                if ids != nil {
                    beers = beers.filter({ (ids!.contains($0.id)) })
                }
                completion?(beers, nil)
            }
        } catch let error {
            completion?(nil, .json(error))
        }
    }
    
}
