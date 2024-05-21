//
//  ProductDetailViewController.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//

import Foundation
import UIKit
import SwiftUI

class ProductDetailViewController: UIViewController {
    var product: Product
    @Binding var cartItems: [CartProduct]

    init(product: Product, cartItems: Binding<[CartProduct]>) {
        self._cartItems = cartItems
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIHostingController(rootView: ProductDetailView(product: product, cartItems: $cartItems))
        addChild(view)
        view.view.frame = self.view.bounds
        self.view.addSubview(view.view)
        view.didMove(toParent: self)

        self.view.backgroundColor = .white
    }
}

struct ProductDetailPresenter: UIViewControllerRepresentable {
    var product: Product
    @Binding var cartItems: [CartProduct]
    typealias UIViewControllerType = ProductDetailViewController

    func makeUIViewController(context: Context) -> ProductDetailViewController {
        ProductDetailViewController(product: product, cartItems: $cartItems)
    }

    func updateUIViewController(_ uiViewController: ProductDetailViewController, context: Context) {
    }
}
