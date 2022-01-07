//
//  BrandCell.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 07/01/2022.
//

import UIKit

final class BrandCell: UICollectionViewCell {
    
    static let identifier = "BrendCell"
    private var isBrandSelected: Bool = false
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkGray
        label.text = "All"
        label.isHidden = true
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.04
        contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureCell(with brand: String) {
        if !brand.isEmpty {
            titleLabel.isHidden = false
            titleLabel.text = brand
        } else {
            configureFirstCell()
        }
    }
    
    private func configureFirstCell() {
        titleLabel.isHidden = false
        contentView.backgroundColor = UIColor(named: "Gray")
    }
    
    func changeCellState() {
        isBrandSelected.toggle()
        
        if isBrandSelected, titleLabel.text != "All" {
            contentView.backgroundColor = UIColor(named: "Accent")
            titleLabel.textColor = .white
        } else {
            contentView.backgroundColor = titleLabel.text == "All" ? UIColor(named: "Gray") : .white
            titleLabel.textColor = .darkGray
        }
    }
}
