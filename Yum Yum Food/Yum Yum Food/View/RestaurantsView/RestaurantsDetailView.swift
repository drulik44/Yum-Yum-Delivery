//
//  RestaurantsDetailView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.01.2025.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class RestaurantDetailView: UIView {
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
    
    let restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 30)
        label.textColor = AppColors.topographyHome
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite 2"), for: .normal)
        button.tintColor = AppColors.gray
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 18)
        label.textColor = AppColors.grayForTextCell
        label.numberOfLines = 0
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    let ratingImageView: UIImageView = {
        let imageView = UIImageView()
        if let originalImage = UIImage(named: "rate") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintedImage
        }
        imageView.tintColor = AppColors.main
        return imageView
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 16)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    let deliveryTimeImage: UIImageView = {
        let imageView = UIImageView()
        if let originalImage = UIImage(named: "time") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintedImage
        }
        imageView.tintColor = AppColors.main
        return imageView
    }()
    
    let deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 16)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    let deliverImage: UIImageView = {
        let imageView = UIImageView()
        if let originalImage = UIImage(named: "delivery track") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintedImage
        }
        imageView.tintColor = AppColors.main
        return imageView
    }()
    
    let deliveryPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 16)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 25)
        label.textColor = AppColors.topographyHome
        label.text = "Menu".localized()
        return label
    }()
    
    let menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
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
        
        contentView.addSubview(restaurantImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(ratingImageView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(deliveryTimeImage)
        contentView.addSubview(deliveryTimeLabel)
        contentView.addSubview(deliverImage)
        contentView.addSubview(deliveryPriceLabel)
        contentView.addSubview(menuLabel)
        contentView.addSubview(menuCollectionView)
    }
    
    private func setupConstraints() {
        
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1700)
        }
        
        restaurantImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).priority(.high)
            make.top.equalTo(scrollView.snp.top).priority(.low)
            make.height.equalTo(300)
            make.width.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantImageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        ratingImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingImageView)
            make.left.equalTo(ratingImageView.snp.right).offset(4)
        }
        
        deliveryTimeImage.snp.makeConstraints { make in
            make.top.equalTo(ratingImageView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        
        deliveryTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryTimeImage)
            make.left.equalTo(deliveryTimeImage.snp.right).offset(4)
        }
        
        deliverImage.snp.makeConstraints { make in
            make.top.equalTo(deliveryTimeLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        
        deliveryPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliverImage)
            make.left.equalTo(deliverImage.snp.right).offset(4)
        }
        
        menuLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryPriceLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configure(with restaurant: Restaurant) {
        if let url = URL(string: restaurant.imageUrl) {
            restaurantImageView.sd_setImage(with: url, completed: nil)
        }
        
        nameLabel.text = restaurant.name.localized()
        descriptionLabel.text = restaurant.description.localized()
        ratingLabel.text = String(format: "rating_format".localized(), String(restaurant.rating))
        deliveryTimeLabel.text = formattedDeliveryTime(restaurant.deliveryTime)
        deliveryPriceLabel.text = String(format: "delivery_price_format".localized(), restaurant.deliveryPrice)
    }
    
    private func formattedDeliveryTime(_ time: String) -> String {
        let cleanedTime = time.replacingOccurrences(of: "min", with: "")
        return String(format: "delivery_time_format".localized(), cleanedTime.trimmingCharacters(in: .whitespaces))
    }
}
