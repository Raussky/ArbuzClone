//
//  SearchBar.swift
//  ArbuzClone
//
//  Created by Rauan on 21.05.2024.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search..."
        
        searchBar.barTintColor = UIColor.white
        searchBar.searchTextField.backgroundColor = UIColor.white
        searchBar.searchTextField.textColor = UIColor.black
        searchBar.searchTextField.font = UIFont.systemFont(ofSize: 17)
        searchBar.searchTextField.placeholder = "Search products..."
        searchBar.tintColor = UIColor.blue
        
        let placeholderAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Искать на Арбузе", attributes: placeholderAttributes)
        
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}
