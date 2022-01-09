//
//  ErrorView.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 08/01/2022.
//

import UIKit

final class ErrorView: UIViewController {

    private lazy var errorStack: StandardVerticalStack = StandardVerticalStack()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark.octagon.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "Font")
        return imageView
    }()
    
    private lazy var errorText: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Font")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Thin", size: 24)
        return label
    }()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "Background")
        view.addSubview(errorStack)
        errorStack.addArrangedSubview(imageView)
        errorStack.addArrangedSubview(errorText)
        
        NSLayoutConstraint.activate([
            errorStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorStack.widthAnchor.constraint(equalToConstant: 250),
            
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureView(with error: Error) {
        errorText.text = error.localizedDescription
    }
}
