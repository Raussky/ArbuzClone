//
//  HeartButton.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//

import SwiftUI

struct HeartButton: View {
    @Binding var isFavorite: Bool

    var body: some View {
        Button(action: {
            withAnimation {
                isFavorite.toggle()
            }
        }) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .foregroundColor(isFavorite ? .red : .black)
                .scaleEffect(isFavorite ? 1.2 : 1.0)
                .animation(.easeInOut(duration: 0.4), value: isFavorite)
                .font(.title3)
        }
    }
}
