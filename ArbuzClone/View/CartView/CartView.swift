//
//  CartVIew.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//

import SwiftUI
import Lottie
import UIKit

struct CartView: View {
    @Binding var cartItems: [CartProduct]
    @State private var isShowingLoader = false
    @State private var isShowingCheckout = false
    private let freeShippingThreshold = 8000.0

    var body: some View {
        NavigationView {
            VStack {
                if cartItems.isEmpty {
                    VStack {
                        LottieView(loopMode: .loop, name: "cart")
                            .scaleEffect(0.5)
                            .frame(width: 200, height: 200)
                            .padding()
                        Text("Вашей корзине ничего нет!")
                            .font(.title)
                            .padding()
                    }
                } else {
                    CartViewControllerRepresentable(cartItems: cartItems)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    if totalCost < freeShippingThreshold {
                        Text("Добавь \(String(format: "%.2f", freeShippingThreshold - totalCost)) Т для бесплатной доставки!")
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(10)
                            .padding()
                    }
                    HStack {
                        Text("Общая сумма: \(String(format: "%.2f", totalCost)) Т")
                            .font(.title)
                            .padding()
                        Spacer()
                    }
                    Button(action: startCheckout) {
                        Text("Оплата")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .navigationBarTitle("Корзина", displayMode: .inline)
            .sheet(isPresented: $isShowingCheckout) {
                Text("Hello World!")
                    .font(.largeTitle)
                    .padding()
            }
            .overlay(loadingOverlay)
        }
    }

    private var totalCost: Double {
        cartItems.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
    }

    private func startCheckout() {
        isShowingLoader = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isShowingLoader = false
            isShowingCheckout = true
        }
    }

    private var loadingOverlay: some View {
        Group {
            if isShowingLoader {
                ZStack {
                    Color.black.opacity(0.5).ignoresSafeArea()
                    ProgressView("Валидация карты...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                }
            }
        }
    }
}





