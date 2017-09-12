//
//  BeerListInteractor.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

class BeerListInteractor {
    
    private var dataManager: APIClient
    
    init(dataManager: APIClient = PunkAPI()) {
        self.dataManager = dataManager
    }
    
    func listBeers(completion: ErrorCompletionBlock?) {
        dataManager.listBeers(ids: nil, completion: completion)
    }
    
    func listFavorites(completion: ErrorCompletionBlock?) {
        if let favoritesIds = AppDefaults.instance.getFavoritesIds() {
            dataManager.listBeers(ids: favoritesIds, completion: completion)
        } else {
            completion?(nil, nil)
        }
    }
    
}

