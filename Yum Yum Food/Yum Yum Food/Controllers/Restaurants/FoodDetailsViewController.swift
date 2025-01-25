//
//  FoodDetailsViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 19.12.2024.
//

import UIKit
import SnapKit
import SDWebImage


class FoodDetailsViewController: UIViewController {
    weak var coordinator: RestaurantsCoordinator?
    
    private let foodDetailsView = FoodDetailsView()
    private let foodDetailsModel = FoodDetailsModel()
    
    var menuItem: MenuItem? {
        didSet {
            if let menuItem = menuItem {
                foodDetailsView.configure(with: menuItem)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        view.addSubview(foodDetailsView)
        foodDetailsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        foodDetailsView.likeButtonFood.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        foodDetailsView.selectedButton.addTarget(self, action: #selector(selectedButtonTapped), for: .touchUpInside)
        foodDetailsView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        foodDetailsView.addToCartButton.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
    }
    
    @objc private func didTapLikeButton() {
        foodDetailsView.likeButtonFood.isSelected.toggle()
        
        guard let menuItem = menuItem else { return }
        
        if foodDetailsView.likeButtonFood.isSelected {
            foodDetailsView.likeButtonFood.setImage(UIImage(named: "favorite tapped"), for: .normal)
            foodDetailsView.likeButtonFood.tintColor = AppColors.main
            foodDetailsModel.addToFavorites(item: menuItem)
        } else {
            foodDetailsView.likeButtonFood.setImage(UIImage(named: "favorite 2"), for: .normal)
            foodDetailsView.likeButtonFood.tintColor = AppColors.gray
            foodDetailsModel.removeFromFavorites(item: menuItem)
        }
    }
    
    @objc private func selectedButtonTapped() {
        foodDetailsView.selectedButton.isSelected.toggle()
        if foodDetailsView.selectedButton.isSelected {
            foodDetailsView.selectedButton.setImage(UIImage(systemName: "record.circle.fill"), for: .normal)
            foodDetailsView.selectedButton.tintColor = AppColors.main
        } else {
            foodDetailsView.selectedButton.setImage(UIImage(systemName: "circle"), for: .normal)
            foodDetailsView.selectedButton.tintColor = AppColors.main
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addToCartButtonTapped() {
        guard let menuItem = menuItem else {
            print("Menu item is nil")
            return
        }
        
        let quantity = foodDetailsView.incrementDecrementView.quantity
        let includePackage = foodDetailsView.selectedButton.isSelected
        
        foodDetailsModel.addToCart(item: menuItem, quantity: quantity, includePackage: includePackage)
        
        dismiss(animated: true, completion: nil)
        CartManager.shared.showCartBanner()
    }
}
