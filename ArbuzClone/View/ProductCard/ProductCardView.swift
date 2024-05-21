//
//  ProductCardView.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//

import SwiftUI

struct ProductCardView: View {
    var product: Product
    @State private var showingDetail = false
    @State private var quantity: Int = 0
    @State private var isFavorite: Bool

    init(product: Product) {
        self.product = product
        _isFavorite = State(initialValue: product.isFavorite)
    }
    var body: some View {
        VStack(alignment: .center){
            HeartButton(isFavorite: $isFavorite)
                .padding(.leading,120)
            Button(action: { showingDetail = true }) {
                VStack{
                    Image(product.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(10)
                    HStack {
                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.headline)
                                .foregroundColor(.black)
                            HStack {
                                if quantity > 0 {
                                    Text("\(Double(quantity) * product.price, specifier: "%.0f") Т")
                                        .foregroundColor(.gray)
                                    Text("· \(quantity) шт")
                                        .foregroundColor(.green)
                                        .font(.subheadline)
                                } else {
                                    HStack{
                                        Text("\(product.price, specifier: "%.0f") Т/шт")
                                            .foregroundColor(.gray)
                                            .font(.subheadline)
                                        Text("· 1 шт")
                                            .foregroundColor(.green)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
            .sheet(isPresented: $showingDetail) {
                ProductDetailPresenter(product: product)
            }
            if quantity == 0 {
                addButton
            } else {
                quantityStepper
            }
                        
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    var addButton: some View {
           Button(action: {
               withAnimation {
                   quantity = 1
               }
           }) {
               HStack {
                   Text("\(product.price, specifier: "%.0f")Т")
                       .foregroundColor(Color.gray)
                   Spacer()
                   Image(systemName: "plus")
                       .foregroundColor(Color.green)
                       .font(.title2)
               }
               .padding(12)
               .background(Color.gray.opacity(0.1))
               .cornerRadius(20)
           }
       }

       var quantityStepper: some View {
           HStack {
               Button(action: {
                   if quantity > 1 {
                       withAnimation {
                           quantity -= 1
                       }
                   } else {
                       withAnimation {
                           quantity = 0
                       }
                   }
               }) {
                   Image(systemName: "minus")
                       .padding(10)
                       .foregroundColor(Color.white)
               }
               Text("\(quantity)")
                   .padding(.horizontal, 8)
                   .frame(minWidth: 36)
                   .foregroundColor(Color.white)
               Button(action: {
                   withAnimation {
                       quantity += 1
                   }
               }) {
                   Image(systemName: "plus")
                       .padding(10)
                       .foregroundColor(Color.white)
               }
           }
           .font(.title2)
           .frame(width: 150)
           .background(Color.green)
           .cornerRadius(15)
       }
}

