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

import UIKit

class RestaurantsViewController: UIViewController {
    weak var coordinator: RestaurantsCoordinator?
    
    private let restaurantsView = RestaurantsView()
    private let restaurantsModel = RestaurantsModel()
    
    private var restaurants: [Restaurant] = []
    private let categories: [Category] = [
        Category(name: "Japanese cuisine".localized(), imageName: "seafood"),
        Category(name: "Bar and Pub".localized(), imageName: "pub"),
        Category(name: "Italian cuisine".localized(), imageName: "pizza"),
        Category(name: "Fastfood".localized(), imageName: "fastfood"),
        Category(name: "Desserts".localized(), imageName: "desserts")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        view.addSubview(restaurantsView)
        restaurantsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        restaurantsView.categoriesCollectionView.delegate = self
        restaurantsView.categoriesCollectionView.dataSource = self
        restaurantsView.restaurantsCollectionView.delegate = self
        restaurantsView.restaurantsCollectionView.dataSource = self
        
        fetchRestaurants()
        restaurantsView.restaurantsCollectionView.isScrollEnabled = false
    }
    
    private func fetchRestaurants() {
        restaurantsModel.fetchRestaurants { [weak self] restaurants in
            self?.restaurants = restaurants
            self?.restaurantsView.restaurantsCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension RestaurantsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == restaurantsView.categoriesCollectionView {
            return categories.count
        } else {
            return restaurants.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == restaurantsView.restaurantsCollectionView {
            let restaurant = restaurants[indexPath.item]
            coordinator?.showRestaurantDetail(for: restaurant)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == restaurantsView.categoriesCollectionView {
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
        if collectionView == restaurantsView.categoriesCollectionView {
            return CGSize(width: 120, height: 140)
        } else if collectionView == restaurantsView.restaurantsCollectionView {
            return CGSize(width: 350, height: 250)
        }
        return CGSize(width: 0, height: 0)
    }
}
