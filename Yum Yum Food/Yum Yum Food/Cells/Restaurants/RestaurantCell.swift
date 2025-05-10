//
//  File.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 10.05.2025.
//

import Foundation
import UIKit
import SnapKit



class RestaurantCell: UICollectionViewCell {
    
   
    static let reusableId = "RestaurantCell"
    
    var data: Restaurant? {
           didSet {
               if let restaurant = data {
                   configure(with: restaurant)
               }
           }
       }

    
    private let restaurantsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
   
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of:16)
        label.textColor = AppColors.topographyHome
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of:14)
        label.textColor = AppColors.grayForTextCell
        
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    private let deliverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "delivery track")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let deliveryTimeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "time")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of:14)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    private let ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rate")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of:14)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    private let deliveryPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of:14)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    private let priceView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wallet-2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(restaurantsImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(deliverImage)
        contentView.addSubview(deliveryTimeImage)
        contentView.addSubview(deliveryTimeLabel)
        contentView.addSubview(ratingImage)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(deliveryPriceLabel)
        contentView.addSubview(priceView)
        
    }
    
    private func setupConstraints() {
        restaurantsImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(170)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantsImageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(16)
        }

        deliverImage.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(16)
        }

        deliveryPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliverImage)
            make.left.equalTo(deliverImage.snp.right).offset(2)
        }

        deliveryTimeImage.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryPriceLabel)
            make.left.equalTo(deliveryPriceLabel.snp.right).offset(8)
            make.width.height.equalTo(16)
        }

        deliveryTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryTimeImage)
            make.left.equalTo(deliveryTimeImage.snp.right).offset(2)
        }

        ratingImage.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryTimeLabel)
            make.left.equalTo(deliveryTimeLabel.snp.right).offset(8)
            make.width.height.equalTo(16)
        }

        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingImage)
            make.left.equalTo(ratingImage.snp.right).offset(2)
        }
        
        
    }
    
    func configure(with restaurant: Restaurant) {
        nameLabel.text = restaurant.name.localized()
        descriptionLabel.text = restaurant.description.localized()
        deliveryPriceLabel.text = "\(restaurant.deliveryPrice)"
        descriptionLabel.text = restaurant.description.localized()
        deliveryTimeLabel.text = restaurant.deliveryTime.localized()
        ratingLabel.text = "\(restaurant.rating)"
            
        if let url = URL(string: restaurant.imageUrl) {
            restaurantsImageView.sd_setImage(with: url, completed: nil)
        } else {
            restaurantsImageView.image = UIImage(named: "defaultImage")
        }
    }
    
    
}
