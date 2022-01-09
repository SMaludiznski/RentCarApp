//
//  MainCarInfoView.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 09/01/2022.
//

import UIKit

final class MainCarInfoView: UIView {
    
    private lazy var mainStack = StandardVerticalStack()
    
    private lazy var imageStack = StandardHorizontalStack()
    private lazy var carImage: StandardImage = StandardImage(image: nil)
    
    private lazy var nameStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        return stack
    }()
    
    private lazy var carName: CarInfoLabel = {
        let label = CarInfoLabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var carYearOfProduction: CarInfoLabel = {
        let label = CarInfoLabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(named: "DarkFont")
        self.layer.cornerRadius = 40
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.clipsToBounds = true
        self.addSubview(mainStack)
        
        mainStack.addArrangedSubview(nameStack)
        
        nameStack.addArrangedSubview(carName)
        nameStack.addArrangedSubview(carYearOfProduction)
        
        mainStack.addArrangedSubview(imageStack)
        imageStack.addArrangedSubview(UIView())
        imageStack.addArrangedSubview(carImage)
        imageStack.addArrangedSubview(UIView())
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10),
            
            imageStack.heightAnchor.constraint(equalToConstant: 250),
            
            carImage.centerXAnchor.constraint(equalTo: imageStack.centerXAnchor),
            carImage.centerYAnchor.constraint(equalTo: imageStack.centerYAnchor),
            carImage.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.85),
            carImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureView(with car: Car, and carDetails: CarDetails) {
        carName.text = "\(car.brand) \(car.model)"
        carYearOfProduction.text = "\(car.yearOfProduction)"
        
        carImage.configureImage(with: car.photo)
    }
}
