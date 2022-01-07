//
//  CarCellCollectionViewCell.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 07/01/2022.
//

import UIKit

final class CarCell: UICollectionViewCell {
    
    static let identifier = "CarCell"
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    private var imageURL: String = ""
    
    private lazy var cellContainer: UIView = {
        let cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 20
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.cornerRadius = 8
        cellView.layer.shadowOpacity = 0.05
        cellView.layer.shadowOffset = CGSize(width: 4, height: 5)
        return cellView
    }()
    
    private lazy var carImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
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
        
        contentView.addSubview(cellContainer)
        cellContainer.addSubview(carImage)
        
        NSLayoutConstraint.activate([
            cellContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            cellContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cellContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            cellContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            carImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            carImage.leadingAnchor.constraint(equalTo: cellContainer.leadingAnchor),
            carImage.widthAnchor.constraint(equalToConstant: 200),
            carImage.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func configureCell(with car: Car) {
        imageURL = car.photo
        getCarImage()
    }
    
    private func getCarImage() {
        networkManager.downloadData(from: imageURL) { [weak self] (completion) in
            switch completion {
            case .success(let data):
                self?.generateImage(from: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func generateImage(from data: Data) {
        DispatchQueue.main.async { [weak self] in
            if let image = UIImage(data: data) {
                self?.carImage.image = image
            }
        }
    }
}
