//
//  AppDefaults.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 05/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

class AppDefaults {
    static let instance = AppDefaults()
    
    private init() {}
    
    private let favoritesKey = "Favorites"
    
    func addFavorite(beer: Beer) {
        if var favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] {
            if !favorites.contains(beer.id) {
                favorites.append(beer.id)
                UserDefaults.standard.set(favorites, forKey: favoritesKey)
                UserDefaults.standard.synchronize()
            }
        } else {
            UserDefaults.standard.set([beer.id], forKey: favoritesKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func removeFavorite(beer: Beer) {
        if var favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [Int], let index = favorites.index(of: beer.id) {
            favorites.remove(at: index)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func isFavorite(beer: Beer) -> Bool {
        guard let favorites = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] else {
            return false
        }
        
        return favorites.contains(beer.id)
    }
    
    func getFavoritesIds() -> [Int]? {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int]
    }
    
}
