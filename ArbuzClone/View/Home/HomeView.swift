//
//  HomeView.swift
//  ArbuzClone
//
//  Created by Rauan on 20.05.2024.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @Binding var cartItems: [CartProduct]
    @State private var searchText = ""
    var products: [Product] = [
        Product(name: "Яблоко", detail: "Насладитесь каждым укусом свежих и сочных яблок, выращенных в экологически чистых условиях. Эти яблоки идеально подходят для утреннего смузи, освежающего салата или просто как здоровый перекус.", price: 2, image: "apple", isFavorite: false),
        Product(name: "Виноград", detail: "Отведайте эти сладкие и сочные ягоды, каждая из которых лопается во рту, оставляя неповторимый вкус. Виноград можно использовать для приготовления вина, в десертах или просто как здоровый перекус.", price: 1, image: "grapes", isFavorite: false),
        Product(name: "Апельсин", detail:"Наши апельсины — это цитрусовая радость, каждый плод изобилует сладким соком и насыщенным ароматом. Подарите себе витаминный буст с апельсинами, идеальными для сока, десертов или просто в качестве освежающего перекуса. Антиоксиданты и витамин C помогут поддержать ваш иммунитет.", price: 1, image: "orange", isFavorite: false),
        Product(name: "Груша", detail: "Эти груши выращены для того, чтобы стать звездой вашего стола. Их нежная мякоть мгновенно тает во рту, оставляя послевкусие сладости и свежести. ", price: 1, image: "peanut", isFavorite: false),
        Product(name: "Лемон", detail: "Эти лимоны собраны в разгаре их спелости, чтобы вы могли наслаждаться идеальным балансом кислоты и сладости. Лимоны идеально подходят для приготовления лимонада, добавления в чай или использования в кулинарии.", price: 1, image: "lemon", isFavorite: false),
    ]
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return products
        } else {
            return products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.horizontal, 10)
                ScrollView {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(products) { product in
                                    ProductCardView(product: product, cartItems: $cartItems)
                                        .frame(width: 200)
                                        .padding(.leading, 10)
                                }
                            }
                            .frame(height: 350)
                        }
                        
                        LazyVGrid(columns: [GridItem(), GridItem()]) {
                            ForEach(filteredProducts) { product in
                                ProductCardView(product: product, cartItems: $cartItems)
                                    .padding(5)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}



class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    @State private var cartItems: [CartProduct] = []
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        
        print("Setting up window with TabBarController")
        let tabBarController = UITabBarController()
        let homeViewController = UIHostingController(rootView: HomeView(cartItems: $cartItems))
        let cartViewController = UIHostingController(rootView: CartView(cartItems: .constant([])))

        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        cartViewController.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart.fill"), tag: 1)

        tabBarController.setViewControllers([homeViewController, cartViewController], animated: false)

        

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}



struct ContentView: View {
    @State private var cartItems: [CartProduct] = []
    var body: some View {
        TabView {
            HomeView(cartItems: $cartItems)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            CartView(cartItems: $cartItems)
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
        }
    }
}


#Preview {
    ContentView()
}
