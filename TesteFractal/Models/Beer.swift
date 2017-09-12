//
//  Beer.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//


import Foundation

struct Beer {
    let id: Int
    let name: String
    let tagline: String
    let description: String
    let imageUrl: URL
    let abv: Float
    let volume: Volume
    // ....
    
    var viewModel: BeerViewModel {
        return BeerViewModel(imageUrl: imageUrl, name: name, tagline: tagline, abv: abv, referencedModel: self, description: description)
    }
}

extension Beer: JSONDecodable {
    init(json: JSON) {
        guard let id = json["id"] as? Int else {
            fatalError("Missing id")
        }
        
        guard let name = json["name"] as? String else {
            fatalError("Missing name")
        }
        
        guard let tagline = json["tagline"] as? String else {
            fatalError("Missing tagline")
        }
        
        guard let description = json["description"] as? String else {
            fatalError("Missing description")
        }
        
        guard let imageUrlString = json["image_url"] as? String else {
            fatalError("Missing image_url")
        }
        
        guard let imageUrl = URL(string: imageUrlString) else {
            fatalError("Invalid string url \(imageUrlString)")
        }
        
        guard let abv = json["abv"] as? Float else {
            fatalError("Missing abv")
        }
        
        guard let volumeJson = json["volume"] as? JSON else {
            fatalError("Some required field not found!")
        }
        
        let volume = Volume(json: volumeJson)
        self.init(id: id, name: name, tagline: tagline, description: description, imageUrl: imageUrl, abv: abv, volume: volume)
    }
}

extension Beer: Equatable { }

func ==(lhs: Beer, rhs: Beer) -> Bool {
    return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.tagline == rhs.tagline
        && lhs.description == rhs.description
        && lhs.imageUrl == rhs.imageUrl
        && lhs.abv == rhs.abv
        && lhs.volume == rhs.volume
        && lhs.isFavorite == rhs.isFavorite
    // ....
}




protocol Favoritable {
    var isFavorite: Bool { get set }
}

extension Beer: Favoritable {
    
    var isFavorite: Bool {
        get {
            return AppDefaults.instance.isFavorite(beer: self)
        }
        
        set {
            if newValue {
                AppDefaults.instance.addFavorite(beer: self)
            } else {
                AppDefaults.instance.removeFavorite(beer: self)
            }
        }
    }

    
}


