//
//  Product.swift
//  ArbuzClone
//
//  Created by Rauan on 20.05.2024.
//

import Foundation


struct Product: Identifiable {
    let id = UUID()
    let name: String
    let detail: String
    let price: Double
    let image: String
    var isFavorite: Bool
}
