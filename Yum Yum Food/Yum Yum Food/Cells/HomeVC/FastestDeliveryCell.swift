//
//  FoodCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 08.12.2024.
//

import UIKit
import SnapKit

class FastestDeliveryCell: UICollectionViewCell {
    
    var data: FoodItem? {
        didSet {
            manageData()
        }
    }
    static let reusableId = "FastestDeliveryCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private let  deliverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "delivery track")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rate")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let deliveryTimeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "time")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 16)
        label.textColor = AppColors.topographyHome
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 14)
        label.textColor = AppColors.grayForTextCell
        label.numberOfLines = 1
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    private let deliveryPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 14)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 14)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    private let deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 14)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()

        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = false
        contentView.backgroundColor = .white
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(deliveryTimeLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(deliveryPriceLabel)
        contentView.addSubview(deliverImage)
        contentView.addSubview(ratingImage)
        contentView.addSubview(deliveryTimeImage)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(110)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(8)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(8)
        }
        
        deliverImage.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(9)
            make.left.equalToSuperview().inset (10)
        }
        
        deliveryPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.equalTo(deliverImage.snp.right).offset(2)
        }
        
        deliveryTimeImage.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.equalTo(deliveryPriceLabel.snp.right).offset(8)
        }
        
        deliveryTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.equalTo(deliveryTimeImage.snp.right).offset(2)
        }
        
        ratingImage.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.equalTo(deliveryTimeLabel.snp.right).offset(8)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.equalTo(ratingImage.snp.right).offset(2)
        }
    }
    
    private func manageData() {
        guard let item = data else { return }
        imageView.loadImage(from: item.imageUrl)
        titleLabel.text = item.name
        ratingLabel.text = " \(item.rating)"
        deliveryTimeLabel.text = " \(item.deliveryTime.localized())"
        descriptionLabel.text = item.description.localized()
        deliveryPriceLabel.text = " \(item.deliveryPrice)"
    }
}
