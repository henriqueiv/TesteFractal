//
//  BeerListSelectionSegmentedControl.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 05/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import Foundation

enum BeerSelection: Int {
    case all = 0, favorites = 1
    
    static let allValues = [BeerSelection.all, BeerSelection.favorites]
}
