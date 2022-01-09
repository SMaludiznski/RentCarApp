//
//  CarInfoLabel.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 08/01/2022.
//

import UIKit

final class CarInfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont(name: "Avenir-Heavy", size: 20)
        self.textColor = UIColor(named: "DarkFont")
        self.textAlignment = .right
    }
}
