//
//  LottieView.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    let name: String

    func makeUIView(context: Context) -> LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFit
        return animationView
    }

    func updateUIView(_ uiView: LottieAnimationView, context: Context) {
    }
}

