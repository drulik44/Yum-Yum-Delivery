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

        // Закругляем углы непосредственно у contentView
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = false
        contentView.backgroundColor = .white
       // contentView.layer.borderWidth = 1.0
        
       /* layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 6
        layer.masksToBounds = false
        
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowOffset = CGSize(width: 0, height: 3)
        shadowLayer.shadowRadius = 6
        shadowLayer.backgroundColor = UIColor.white.cgColor
        shadowLayer.cornerRadius = 12
        shadowLayer.frame = contentView.frame
        layer.insertSublayer(shadowLayer, at: 0)*/
        
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
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(8)
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
        
        deliveryPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().inset (8)
        }
        
        deliveryTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.left.equalTo(deliveryPriceLabel.snp.right).offset(8)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
            make.left.equalTo(deliveryTimeLabel.snp.right).offset(8)
        }
    }
    
    private func manageData() {
        guard let item = data else { return }
        imageView.loadImage(from: item.imageUrl)
        titleLabel.text = item.name
        ratingLabel.text = " \(item.rating)"
        deliveryTimeLabel.text = " \(item.deliveryTime)"
        descriptionLabel.text = item.description
        deliveryPriceLabel.text = " \(item.deliveryPrice)"
    }
}
