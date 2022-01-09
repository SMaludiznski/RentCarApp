//
//  StandardImage.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 08/01/2022.
//

import UIKit

final class StandardImage: UIImageView {

    private let networkManager: NetworkManagerProtocol = NetworkManager()
    private let cache: ImageCache = ImageCache.shared
    
    private var imageURL: String = ""
    
    override init(image: UIImage?) {
        super.init(image: image)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
    }
    
    func configureImage(with imageUrl: String) {
        self.imageURL = imageUrl
        getCarImage()
    }

    private func getCarImage() {
        guard let image = cache.getImageFromCache(imageURL) else {
            downloadCarImage()
            return
        }
        
        self.image = image
    }
    
    private func downloadCarImage() {
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
                guard let self = self else { return }
                self.image = image
                self.cache.cache(image: image, name: self.imageURL)
            }
        }
    }
}
