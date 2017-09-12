//
//  BeerViewModel.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation
import UIKit

struct BeerViewModel {
    let imageUrl: URL
    let name: String
    let tagline: String
    let abv: Float
    var referencedModel: Beer
    let description: String
}

extension BeerViewModel: Equatable { }
func ==(lhs: BeerViewModel, rhs: BeerViewModel) -> Bool {
    return lhs.imageUrl == rhs.imageUrl
        && lhs.name == rhs.name
        && lhs.tagline == rhs.tagline
        && lhs.abv == rhs.abv
        && lhs.referencedModel == rhs.referencedModel
        && lhs.description == rhs.description
}
