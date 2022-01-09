//
//  CarCellCollectionViewCell.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 07/01/2022.
//

import UIKit

final class CarCell: UICollectionViewCell {
    
    static let identifier = "CarCell"
    
    private lazy var cellContainer: UIView = {
        let cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = .white
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.cornerRadius = 8
        cellView.layer.shadowOpacity = 0.05
        cellView.layer.shadowOffset = CGSize(width: 4, height: 5)
        cellView.layer.cornerRadius = 15
        return cellView
    }()
    
    private lazy var cellStack: StandardVerticalStack = StandardVerticalStack()
    
    private lazy var carStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        return stack
    }()
    
    private lazy var carNameStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var detailStack: StandardHorizontalStack = StandardHorizontalStack()
    private lazy var carImage: StandardImage = StandardImage(image: nil)
    private lazy var carName: CarInfoLabel = CarInfoLabel()
    
    private lazy var carYearOfProduction: CarInfoLabel = {
        let label = CarInfoLabel()
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var rentPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 20)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var detailButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.backgroundColor = UIColor(named: "Accent")
        label.clipsToBounds = true
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        label.layer.cornerRadius = 15
        label.textAlignment = .center
        label.text = "Details"
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
        contentView.addSubview(cellContainer)
        cellContainer.addSubview(cellStack)
        
        cellStack.addArrangedSubview(carStack)
        carStack.addSubview(carImage)
        
        carStack.addArrangedSubview(carNameStack)
        carNameStack.addArrangedSubview(carName)
        carNameStack.addArrangedSubview(carYearOfProduction)
        carNameStack.addArrangedSubview(UIView())
        
        cellStack.addArrangedSubview(UIView())
        cellStack.addArrangedSubview(detailStack)
        detailStack.addArrangedSubview(rentPrice)
        detailStack.addSubview(detailButton)
        
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            cellContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cellStack.topAnchor.constraint(equalTo: cellContainer.topAnchor, constant: 10),
            cellStack.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor, constant: 15),
            cellStack.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor, constant: -15),
            cellStack.bottomAnchor.constraint(equalTo: cellContainer.bottomAnchor, constant: -10),
            
            carStack.heightAnchor.constraint(equalTo: cellStack.heightAnchor, multiplier:  0.5),
            
            carImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            carImage.leadingAnchor.constraint(equalTo: cellStack.leadingAnchor),
            carImage.widthAnchor.constraint(equalTo: cellStack.widthAnchor, multiplier: 0.5),
            carImage.heightAnchor.constraint(equalToConstant: 150),
            
            detailButton.topAnchor.constraint(equalTo: detailStack.topAnchor),
            detailButton.trailingAnchor.constraint(equalTo: cellContainer.trailingAnchor),
            detailButton.bottomAnchor.constraint(equalTo: cellContainer.bottomAnchor),
            detailButton.widthAnchor.constraint(equalTo: cellContainer.widthAnchor, multiplier: 0.5),
        ])
    }
    
    func configureCell(with car: Car) {
        carName.text = "\(car.brand) \(car.model)"
        carYearOfProduction.text = "\(car.yearOfProduction)"
        rentPrice.attributedText = getRentPriceText(from: car.price)
        
        carImage.configureImage(with: car.photo)
    }
    
    private func getRentPriceText(from price: Int) -> NSAttributedString {
        let string = "\(price)"
        let text = "$\(string)/day"
        
        let attributtedText = NSMutableAttributedString(string: text)
        attributtedText.addAttributes([.foregroundColor: UIColor(named: "DarkFont") as Any,
                                       .font: UIFont(name: "Avenir-Heavy", size: 20) as Any
                                      ], range: NSRange(location: 0, length: string.count + 1))
        return attributtedText
    }
}
