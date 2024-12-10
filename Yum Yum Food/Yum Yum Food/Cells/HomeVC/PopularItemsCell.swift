//
//  PopularItemsCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 09.12.2024.
//

import UIKit
import SnapKit

class PopularItemsCell: UICollectionViewCell {
    
    var data: FoodItem? {
        didSet {
            manageData()
        }
    }
    static let reusableId = "PopularItemsCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let priceView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wallet-2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 13)
        label.textColor = AppColors.topographyHome
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameRestaurantLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 14)
        label.textColor = AppColors.grayForTextCell
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 14)
        label.textColor = AppColors.grayForTextCell
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameRestaurantLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            //make.top.left.right.equalToSuperview().inset(8)
            make.height.equalTo(100)
            make.width.equalTo(170)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(8)
        }
        
        nameRestaurantLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(8)
        }
       
        priceView.snp.makeConstraints { make in
            make.top.equalTo(nameRestaurantLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameRestaurantLabel.snp.bottom).offset(8)
            make.left.equalTo(priceView.snp.right).offset(2)
        }
    }
    
    private func manageData() {
        guard let item = data else { return }
        imageView.loadImage(from: item.imageUrl)
        titleLabel.text = item.name
        nameRestaurantLabel.text = item.nameRestaurant
        priceLabel.text = item.price
    }
}
