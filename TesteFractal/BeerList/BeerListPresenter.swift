//
//  BeerListPresenter.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

protocol BeerListInterfaceProtocol: class {
    func didLoad(beers: [BeerViewModel])
    func didOccur(error: Error)
    func showEmptyState()
}

class BeerListPresenter {
    
    private var interactor = BeerListInteractor()
    weak var interface: BeerListInterfaceProtocol?
    
    func loadData() {
        interactor.listBeers {[weak self] (beers: [Beer]?, error: APIError?) in
            if error == nil {
                if beers == nil {
                    self?.interface?.showEmptyState()
                } else {
                    let viewModels = beers!.map { $0.viewModel }
                    self?.interface?.didLoad(beers: viewModels)
                }
            } else {
                self?.interface?.didOccur(error: error!)
            }
        }
    }
    
    func loadFavorites() {
        interactor.listFavorites {[weak self] (beers: [Beer]?, error: APIError?) in
            if error == nil {
                if beers == nil {
                    self?.interface?.showEmptyState()
                } else {
                    let viewModels = beers!.map { $0.viewModel }
                    self?.interface?.didLoad(beers: viewModels)
                }
            } else {
                self?.interface?.didOccur(error: error!)
            }
        }
    }
    
}
