//
//  ProductDetailView.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var cartItems: [CartProduct]
    var product: Product
    @State private var isFavorite: Bool = false
    @State private var nutritionInfoExpanded: Bool = false
    @State private var storageInfoExpanded: Bool = false
    @State private var brandInfoExpanded: Bool = false
    @State private var quantity: Int = 0
    @State private var products: Product? = nil
    @State private var isLoading = true
    init(product: Product, cartItems: Binding<[CartProduct]>) {
        self.product = product
        self._cartItems = cartItems
        self._isFavorite = State(initialValue: product.isFavorite)
    }


    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                            .font(.title2)
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isFavorite.toggle()
                        }
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .black)
                            .scaleEffect(isFavorite ? 1.2 : 1.0)
                            .animation(.easeInOut(duration: 0.4), value: isFavorite)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 56)
            ScrollView {
                VStack(alignment: .center) {
                    Image(product.image)
                        .resizable()
                        .cornerRadius(15)
                        .scaledToFit()
                        .frame(maxHeight: 300)
                    Text(product.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top)
                    Text("\(product.price, specifier: "%.0f") Т/шт")
                        .font(.title3)
                        .foregroundColor(.gray)
                    Text(product.detail)
                        .padding()
                    Divider()
                    DisclosureGroup("Условия хранения", isExpanded: $storageInfoExpanded) {
                        Text("Срок годности: 15 дней, температура хранения: -1...+5 °C")
                            .padding()
                    }
                    .accentColor(.black)
                    .padding()
                    Divider()
                    DisclosureGroup("Бренд", isExpanded: $brandInfoExpanded) {
                        Text("Арбуз Select")
                    }
                    .accentColor(.black)
                    .padding()
                    Divider()
                    DisclosureGroup("Страна", isExpanded: $nutritionInfoExpanded) {
                        Text("Казахстан")
                            .padding()
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            if quantity == 0 {
                Button(action: {
                    withAnimation {
                        quantity = 1
                        addToCart(product: product, quantity: quantity)
                    }
                }) {
                    HStack{
                        Spacer()
                        VStack{
                            HStack{
                                Text("\(product.price, specifier: "%.0f") Т")
                                    .foregroundColor(.white)
                                Text("5Т")
                                    .strikethrough()
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            Text("за шт")
                                .foregroundColor(.white)
                        }
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 100)
                    .background(Color.green)
                }
                .padding(.bottom,60)
            } else {
                HStack {
                    Button(action: {
                        if quantity > 1 {
                            withAnimation {
                                quantity -= 1
                                updateCart(product: product, quantity: quantity)
                            }
                        } else {
                            withAnimation {
                                quantity = 0
                                updateCart(product: product, quantity: quantity)
                            }
                        }
                    }) {
                        Image(systemName: "minus")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    Spacer()
                    VStack{
                        Text("\(Double(quantity) * product.price, specifier: "%.0f")Т")
                            .foregroundColor(.white)
                            .font(.headline)
                        Text("\(quantity) шт")
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            quantity += 1
                            updateCart(product: product, quantity: quantity)
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 100)
                .background(Color.green)
                .padding(.bottom, 60)
            }
        }
        .edgesIgnoringSafeArea(.top)
        
        
    }
    func addToCart(product: Product, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += quantity
        } else {
            cartItems.append(CartProduct(product: product, quantity: quantity))
        }
    }

    func updateCart(product: Product, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            if quantity == 0 {
                cartItems.remove(at: index)
            } else {
                cartItems[index].quantity = quantity
            }
        }
    }
}
