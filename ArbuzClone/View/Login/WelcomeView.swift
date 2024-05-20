//
//  WelcomeView.swift
//  ArbuzClone
//
//  Created by Rauan on 20.05.2024.
//

import SwiftUI
var totalPages = 3

struct WelcomeView:View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        ZStack{
            if currentPage == 1{
                ScreenView(image: "onboarding", title: "Order Food", detail: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel.")
            }
            if currentPage == 2{
                ScreenView(image: "onboarding2", title: "Easy Delivery", detail: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel.")
            }
            if currentPage == 3{
                ScreenView(image: "onboarding3", title: "Fast Delivery", detail: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,molestiae quas vel.")
            }
        }
        
    }
}




    
#Preview {
    WelcomeView()
}
