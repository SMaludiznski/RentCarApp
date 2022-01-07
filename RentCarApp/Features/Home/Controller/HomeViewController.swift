//
//  HomeViewController.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 06/01/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    private let parseDataManager: ParseDataManagerProtocol = ParseDataManager()
    
    private lazy var navTitleLabel: NavTitleLabel = NavTitleLabel()
    private lazy var searchBar: SearchBar = SearchBar()
    
    private lazy var brandsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    private lazy var carsCollection: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var cars: [Car] = []
    private var brands: [String] = ["Mercedes", "Audi"]
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = UIColor(named: "Background")
        stack.spacing = 15
        return stack
    }()
    
    private lazy var brandsSectionTitle: SectionTitle = SectionTitle()
    private lazy var carsSectionTitle: SectionTitle = SectionTitle()

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadCars()
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        setupNavigation()
        setupBrandsCollection()
        setupCarsCollection()
        
        view.backgroundColor = UIColor(named: "Background")
        brandsSectionTitle.text = "Brands"
        carsSectionTitle.text = "Available cars"
        
        view.addSubview(mainStack)
        
        mainStack.addArrangedSubview(brandsSectionTitle)
        mainStack.addArrangedSubview(brandsCollection)
        mainStack.addArrangedSubview(carsSectionTitle)
        mainStack.addArrangedSubview(carsCollection)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            brandsCollection.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupNavigation() {
        searchBar.sizeToFit()
        navigationController?.navigationBar.tintColor = UIColor(named: "Font")
        showNavTitle()
    }
    
    @objc private func showNavTitle() {
        navigationItem.titleView = navTitleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
    }
    
    @objc private func showSearchBar() {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(showNavTitle))
    }
    
    private func setupBrandsCollection() {
        setupCollection(brandsCollection)
        brandsCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        brandsCollection.showsHorizontalScrollIndicator = false
    }
    
    private func setupCarsCollection() {
        setupCollection(carsCollection)
        carsCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        carsCollection.showsVerticalScrollIndicator = false
    }
    
    private func setupCollection(_ collection: UICollectionView) {
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "Background")
    }
    
    private func downloadCars() {
        networkManager.downloadData(from: Constants.apiUrl) { [weak self] (completion) in
            switch completion {
            case .success(let data):
                self?.generateCars(from: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func generateCars(from data: Data) {
        do {
            let decodedData = try parseDataManager.parseData(from: data, expecting: [Car].self)
            reloadView(with: decodedData)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func reloadView(with cars: [Car]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cars = cars
            self.carsCollection.reloadData()
        }
    }
}

//MARK: - Setup collections
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == brandsCollection {
            return 5
        }
        
        return cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == brandsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemYellow
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemPink.withAlphaComponent(0.5)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == brandsCollection {
            return CGSize(width: 85, height: 85)
        }
        return CGSize(width: mainStack.bounds.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == brandsCollection {
            return 15
        }
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}