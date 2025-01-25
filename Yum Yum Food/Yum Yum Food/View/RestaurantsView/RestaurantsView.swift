//
//  RestaurantsView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.01.2025.
//

import Foundation
import UIKit
import SnapKit

class RestaurantsView: UIView {
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 30)
        label.textAlignment = .left
        label.text = "Restaurants".localized()
        return label
    }()
    
    let categoriesLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 25)
        label.textAlignment = .left
        label.text = "Categories".localized()
        return label
    }()
    
    let seeAllButton = CustomButton()
    
    let categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        return collectionView
    }()
    
    let allRestaurantsLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 25)
        label.textAlignment = .left
        label.text = "All Restaurants".localized()
        return label
    }()
    
    let restaurantsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = AppColors.background
        collectionView.register(RestaurantCell.self, forCellWithReuseIdentifier: RestaurantCell.reusableId)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(scrollView)
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
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(2800) // Задайте достаточную высоту для отображения всех элементов
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
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
}
