//
//  PunkAPI.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

final class PunkAPI: APIClient {
    
    private enum Enpoint {
        case beers([Int]?)
        
        var url: URL {
            var urlString = "https://api.punkapi.com/v2"
            switch self {
            case .beers(let ids):
                urlString += "/beers/"
                if ids != nil, let encodedIds = ids!.joined(separator: "|").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    urlString += "?ids=" + encodedIds
                }
            }
            
            return URL(string: urlString)!
        }
    }
    
    func listBeers(ids: [Int]?, completion: ErrorCompletionBlock?) {
        URLSession.shared.dataTask(with: Enpoint.beers(ids).url) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                do {
                    if let beersJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [JSON] {
                        let beers = beersJson.map({ Beer(json: $0) })
                        completion?(beers, nil)
                    }
                } catch let jsonError {
                    completion?(nil, .json(jsonError))
                }
            } else {
                completion?(nil, .json("Data nil"))
            }
            }.resume()
    }
    
    
}
