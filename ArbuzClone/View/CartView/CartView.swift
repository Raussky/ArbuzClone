//
//  CartVIew.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//

import SwiftUI

struct CartView: View {
    @Binding var cartItems: [Product]

    var body: some View {
        List(cartItems) { item in
            HStack {
                Text(item.name)
                Spacer()
                Text("\(item.price, specifier: "%.2f")")
            }
        }
        .navigationTitle("Cart")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Checkout") {
                    // Логика чекаута
                }
            }
        }
    }
}

