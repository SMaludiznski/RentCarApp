//
//  CarDetailViewController.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 08/01/2022.
//

import UIKit

final class CarDetailViewController: UIViewController {
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    private let parseDataManager: ParseDataManagerProtocol = ParseDataManager()
    
    private lazy var errorView: ErrorView = ErrorView()
    
    private lazy var mainStack: StandardVerticalStack = StandardVerticalStack()
    private lazy var mainInfoStack: StandardVerticalStack = StandardVerticalStack()
    
    private lazy var mainInfo: MainCarInfoView = MainCarInfoView()
    
    private var car: Car?
    private var carDetails: CarDetails?
    private var comfort: [String] = []
    private var carUrl: String = ""
    
    private lazy var backImage: UIImageView = {
        let task = UITapGestureRecognizer(target: self, action: #selector(goBack))
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.backward")
        imageView.tintColor = .white
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
        imageView.contentMode = .scaleToFill
        imageView.addGestureRecognizer(task)
        return imageView
    }()
    
    private lazy var specificationSection: SectionTitle = SectionTitle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadCarDetails()
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backImage)
        view.backgroundColor = UIColor(named: "DarkFont")
        mainStack.backgroundColor = UIColor(named: "Background")
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(mainInfo)
        
        mainStack.addArrangedSubview(UIView())
        
        NSLayoutConstraint.activate([
            
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureView(with car: Car) {
        self.car = car
        generateCarUrl()
        
        specificationSection.text = "Specifications"
    }
    
    private func generateCarUrl() {
        if let car = self.car {
            self.carUrl = "\(Constants.carDetailUrl)\(car.id).json"
        }
    }
    
    private func downloadCarDetails() {
        networkManager.downloadData(from: carUrl) { [weak self] (completion) in
            switch completion {
            case .success(let data):
                self?.generateDetails(from: data)
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
    
    private func generateDetails(from data: Data) {
        do {
            let decodedData = try parseDataManager.parseData(from: data, expecting: CarDetails.self)
            reloadView(with: decodedData)
        } catch {
            show(error: error)
        }
    }
    
    private func reloadView(with carDetails: CarDetails) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let car = self.car
            else { return }
            
            self.errorView.remove()
            self.carDetails = carDetails
            self.mainStack.isHidden = false
            self.mainInfo.configureView(with: car, and: carDetails)
        }
    }
    
    private func show(error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.mainStack.isHidden = true
            self.errorView.configureView(with: error)
            self.add(self.errorView)
        }
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
