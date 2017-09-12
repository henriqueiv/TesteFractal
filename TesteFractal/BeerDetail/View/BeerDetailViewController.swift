//
//  BeerDetailViewController.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 05/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

protocol BeerDetailViewControllerDelegate: class {
    func beerDetailViewController(_ controller: BeerDetailViewController, didFavorite beer: BeerViewModel) -> BeerViewModel 
}

final class BeerDetailViewController: UIViewController {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerTagline: UILabel!
    @IBOutlet weak var beerDescription: UITextView!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    
    private var beer: BeerViewModel {
        didSet {
//            guard oldValue != beer else {
//                debugPrint("Same view model, not updating UI")
//                return
//            }
            
            update(with: beer)
        }
    }
    
    private weak var delegate: BeerDetailViewControllerDelegate?
    
    init(beer: BeerViewModel, delegate: BeerDetailViewControllerDelegate? = nil) {
        self.beer = beer
        self.delegate = delegate
        
        super.init(nibName: "BeerDetailViewController", bundle: Bundle.main)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update(with: self.beer)
        
        let padding: CGFloat = 10
        let topConstraint = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height ?? 0) + padding
        imageTopConstraint.constant = topConstraint
        
        let favoriteBarButtonItemImage = beer.referencedModel.isFavorite ? Image.heartFilled.instance : Image.heart.instance
        let favoriteBarButtomItem = UIBarButtonItem(image: favoriteBarButtonItemImage, style: .plain, target: self, action: #selector(didTapFavoriteButtonItem(buttonItem:)))
        navigationItem.setRightBarButton(favoriteBarButtomItem, animated: true)
    }
    
    @objc private func didTapFavoriteButtonItem(buttonItem: UIBarButtonItem) {
        // To keep it unmutable
        if let favoritedBeer = delegate?.beerDetailViewController(self, didFavorite: beer) {
            beer = favoritedBeer
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update(with beer: BeerViewModel) {
        title = beer.name
        
        beerImage.sd_setImage(with: beer.imageUrl)
        beerImage.backgroundColor = .white
        
        beerName.text = beer.name
        beerTagline.text = beer.tagline
        beerDescription.text = beer.description
        
        navigationItem.rightBarButtonItem?.image = beer.referencedModel.isFavorite ? Image.heartFilled.instance : Image.heart.instance
    }
    
}
