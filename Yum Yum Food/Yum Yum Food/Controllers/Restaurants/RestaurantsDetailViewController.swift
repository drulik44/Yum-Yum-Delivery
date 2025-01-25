//
//  RestaurantsDetailViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 14.12.2024.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore
import SDWebImage

import UIKit

class RestaurantDetailViewController: UIViewController {
    weak var coordinator: RestaurantsCoordinator?
    
    private let restaurantDetailView = RestaurantDetailView()
    private let restaurantDetailModel = RestaurantDetailModel()
    
    var restaurant: Restaurant? {
        didSet {
            if let restaurant = restaurant {
                restaurantDetailView.configure(with: restaurant)
                fetchMenuItems(for: restaurant.id)
            }
        }
    }
    
    private var menuItems: [MenuItem] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupCustomBackButton(for: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        view.addSubview(restaurantDetailView)
        restaurantDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        restaurantDetailView.likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        restaurantDetailView.menuCollectionView.dataSource = self
        restaurantDetailView.menuCollectionView.delegate = self
        restaurantDetailView.menuCollectionView.isScrollEnabled = false
        restaurantDetailView.scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    private func fetchMenuItems(for restaurantId: String) {
        restaurantDetailModel.fetchMenuItems(for: restaurantId) { [weak self] menuItems in
            self?.menuItems = menuItems
            self?.restaurantDetailView.menuCollectionView.reloadData()
        }
    }
    
    @objc private func didTapLikeButton() {
        restaurantDetailView.likeButton.isSelected.toggle()
        
        guard let restaurant = restaurant else { return }
        
        let favoriteItem = FavoriteItem(
            id: restaurant.id,
            name: restaurant.name,
            description: restaurant.description,
            imageUrl: restaurant.imageUrl,
            price: "",
            rating: restaurant.rating,
            deliveryTime: restaurant.deliveryTime,
            deliveryPrice: restaurant.deliveryPrice,
            type: .restaurant
        )
        
        if restaurantDetailView.likeButton.isSelected {
            restaurantDetailView.likeButton.setImage(UIImage(named: "favorite tapped"), for: .normal)
            restaurantDetailView.likeButton.tintColor = AppColors.main
            FavoritesManager.shared.addToFavorites(item: favoriteItem)
        } else {
            restaurantDetailView.likeButton.setImage(UIImage(named: "favorite 2"), for: .normal)
            restaurantDetailView.likeButton.tintColor = AppColors.gray
            FavoritesManager.shared.removeFromFavorites(item: favoriteItem)
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension RestaurantDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
        let menuItem = menuItems[indexPath.item]
        cell.configure(with: menuItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMenuItem = menuItems[indexPath.item]
        showFoodDetail(with: selectedMenuItem)
    }
    
    private func showFoodDetail(with menuItem: MenuItem) {
        let foodVC = FoodDetailsViewController()
        foodVC.menuItem = menuItem
        foodVC.modalPresentationStyle = .formSheet
        present(foodVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RestaurantDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: 160)
    }
}
