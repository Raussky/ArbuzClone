//
//  Cart.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//

import Foundation
//import UIKit
//
//class CartManager: ObservableObject {
//    @Published var items: [Product] = []
//    
//    func addToCart(product: Product) {
//        if let index = items.firstIndex(where: { $0.id == product.id }) {
//            items[index].quantity += 1
//        } else {
//            var newProduct = product
//            newProduct.quantity = 1
//            items.append(newProduct)
//        }
//    }
//    
//    func removeFromCart(product: Product) {
//        guard let index = items.firstIndex(where: { $0.id == product.id }) else { return }
//        if items[index].quantity > 1 {
//            items[index].quantity -= 1
//        } else {
//            items.remove(at: index)
//        }
//    }
//    
//    func clearCart() {
//        items.removeAll()
//    }
//}

struct CartProduct: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}
