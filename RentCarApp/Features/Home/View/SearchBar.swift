//
//  SearchBar.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 06/01/2022.
//

import UIKit

final class SearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = "What are you looking for?"
        self.searchBarStyle = .minimal
        self.backgroundColor = .clear
        self.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
    }
}
