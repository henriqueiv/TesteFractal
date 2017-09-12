//
//  AppRouter.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import UIKit

final class AppRouter {
    
    private var window: UIWindow
    private var navigationController: UINavigationController
    
    private var appLaunchOptions: [UIApplicationLaunchOptionsKey: Any]?
    
    init(appLaunchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        self.appLaunchOptions = appLaunchOptions
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigationController = UINavigationController()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showInitialViewController() {
        let controller = BeerListViewController(delegate: self)
        navigationController.viewControllers = [controller]
    }
    
    func showDetail(for beer: BeerViewModel) {
        let controller = BeerDetailViewController(beer: beer, delegate: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
}

extension AppRouter: BeerListViewControllerDelegate {
    func beerListViewController(_ controller: BeerListViewController, didSelect beer: BeerViewModel) {
        showDetail(for: beer)
    }
}

extension AppRouter: BeerDetailViewControllerDelegate {
    func beerDetailViewController(_ controller: BeerDetailViewController, didFavorite beer: BeerViewModel) -> BeerViewModel {
        var favoritedBeerViewModel = beer
        favoritedBeerViewModel.referencedModel.isFavorite = !favoritedBeerViewModel.referencedModel.isFavorite
        return favoritedBeerViewModel
    }
}
