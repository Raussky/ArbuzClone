//
//  CartCollectionView.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//
import Foundation
import UIKit
import SwiftUI

class CartCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var cartItems: [CartProduct] = []
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width - 20, height: 80)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CartItemCell.self, forCellWithReuseIdentifier: "CartItemCell")
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
        let item = cartItems[indexPath.item]
        cell.configure(with: item)
        return cell
    }

    func reloadData() {
        collectionView.reloadData()
    }
}

class CartItemCell: UICollectionViewCell {
    private let nameLabel = UILabel()
    private let quantityLabel = UILabel()
    private let priceLabel = UILabel()
    private let productImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(productImageView)
        addSubview(nameLabel)
        addSubview(quantityLabel)
        addSubview(priceLabel)

        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        productImageView.contentMode = .scaleAspectFit
        productImageView.layer.cornerRadius = 8
        productImageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 50),
            productImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            quantityLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            quantityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(with item: CartProduct) {
        nameLabel.text = item.product.name
        quantityLabel.text = "\(item.quantity) x \(String(format: "%.2f", item.product.price)) Т"
        priceLabel.text = "\(String(format: "%.2f", Double(item.quantity) * item.product.price)) Т"
        productImageView.image = UIImage(named: item.product.image)
    }
}


struct CartViewControllerRepresentable: UIViewControllerRepresentable {
    var cartItems: [CartProduct]
    
    func makeUIViewController(context: Context) -> CartCollectionViewController {
        let viewController = CartCollectionViewController()
        viewController.cartItems = cartItems
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CartCollectionViewController, context: Context) {
        uiViewController.cartItems = cartItems
        uiViewController.reloadData()
    }
}
