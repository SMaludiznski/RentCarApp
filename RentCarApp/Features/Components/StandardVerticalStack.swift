//
//  StandardStack.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 08/01/2022.
//

import UIKit

final class StandardVerticalStack: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.spacing = 10
        self.axis = .vertical
    }
}
