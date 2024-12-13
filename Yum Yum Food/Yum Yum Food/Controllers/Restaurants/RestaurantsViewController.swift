//
//  RestaurantsViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//


import UIKit
import FirebaseFirestore
import Firebase
import SnapKit

class RestaurantsViewController: UIViewController {
    weak var coordinator: RestaurantsCoordinator?
    private let db = Firestore.firestore()
    private var restaurants: [Restaurant] = []

    
    let categories: [Category] = [
        Category(name: "Japanese cuisine", imageName: "seafood"),
        Category(name: "Bar and Pub", imageName: "pub"),
        Category(name: "Italian cuisine", imageName: "pizza"),
        Category(name: "Fastfood", imageName: "fastfood"),
        Category(name: "Desserts", imageName: "desserts")
    ]
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 30)
        label.textAlignment = .left
        label.text = "Restaurants"
        return label
    }()

    private let categoriesLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 25)
        label.textAlignment = .left
        label.text = "Categories"
        return label
    }()

    private let seeAllButton = CustomButton()

    private let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        return collectionView
    }()

    private let allRestaurantsLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 25)
        label.textAlignment = .left
        label.text = "All Restaurants"
        return label
    }()

    private let restaurantsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = AppColors.background
        collectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: RestaurantCell.reusableId)
        return collectionView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background

        setupUI()
        setupConstraints()

        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.dataSource = self

        fetchRestaurants()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoriesLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(categoriesCollectionView)
        contentView.addSubview(allRestaurantsLabel)
        contentView.addSubview(restaurantsCollectionView)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(800) // Задайте достаточную высоту для отображения всех элементов
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
        }

        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
        }

        seeAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(categoriesLabel)
            make.right.equalToSuperview().offset(-30)
            make.width.equalTo(80)
        }

        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().offset(20)
            make.height.equalTo(160)
        }

        allRestaurantsLabel.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
        }

        restaurantsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(allRestaurantsLabel.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }

    // MARK: - Fetch Restaurants
    private func fetchRestaurants() {
        db.collection("restaurants").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                self?.restaurants = querySnapshot?.documents.compactMap { document in
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let rating = data["rating"] as? Double ?? 0.0
                    let deliveryTime = data["deliveryTime"] as? String ?? ""
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    let deliveryPrice = data["deliveryPrice"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                   
                    return Restaurant(name: name, rating: rating, deliveryTime: deliveryTime, imageUrl: imageUrl, deliveryPrice: deliveryPrice, description: description )
                } ?? []
                self?.restaurantsCollectionView.reloadData()
            }
        }
    }}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension RestaurantsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return 5 // Количество категорий
        } else {
            return restaurants.count // Количество ресторанов
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            let category = categories[indexPath.item]
            cell.configure(with: category.name, imageName: category.imageName)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.reusableId, for: indexPath) as! RestaurantCell
            let restaurant = restaurants[indexPath.item]
            cell.data = restaurant
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView ==  categoriesCollectionView{
            return CGSize(width: 120, height: 160)
        } else if collectionView == restaurantsCollectionView {
            return CGSize(width: 350, height: 250) // Укажите нужный размер
        }
        return CGSize(width: 0, height: 0) // Значение по умолчанию (может быть не достигнуто)
    }
}
