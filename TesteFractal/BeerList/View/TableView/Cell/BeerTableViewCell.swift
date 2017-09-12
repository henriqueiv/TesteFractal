//
//  SubjectTableViewCell.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation
import SDWebImage
import UIKit

struct Appearance {
    
    static let tintColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
    
    struct ABV {
        static let light = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        static let moderate = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        static let strong = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        static func color(for value: Float) -> UIColor {
            switch value {
            case -Float.infinity..<6.0:
                return light
                
            case 6.0..<10.0:
                return moderate
                
            default:
                return strong
            }
        }
    }
    
    struct Theme {
        static let lightGray = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    static func install() {
        //        UIWindow.appearance().tintColor = tintColor
    }
}

final class BeerTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    @IBOutlet weak var sideView: RoundedView!
    @IBOutlet weak var beerImage: UIImageView!
    
    var viewModel: BeerViewModel? = nil {
        didSet {
            guard oldValue?.referencedModel != viewModel?.referencedModel else { return }
            
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 2
        cardView.layer.shadowOpacity = 0.25
        cardView.layer.cornerRadius = 5
        cardView.layer.masksToBounds = false
        cardView.clipsToBounds = false
        separatorInset = UIEdgeInsetsMake(0, bounds.size.width, 0, 0);
        selectionStyle = .none
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        
        beerNameLabel.text = viewModel.name
        beerTaglineLabel.text = viewModel.tagline
        sideView.backgroundColor = Appearance.ABV.color(for: viewModel.abv)
        beerImage.sd_setImage(with: viewModel.imageUrl)
    }
    
}
