//
//  MainView.swift
//  ArbuzClone
//
//  Created by Rauan on 20.05.2024.
//

import SwiftUI

struct MainView:View {
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        if currentPage > totalPages {
            HomeView()
        }
        else {
            WelcomeView()
        }
    }
}

#Preview {
    MainView()
}
