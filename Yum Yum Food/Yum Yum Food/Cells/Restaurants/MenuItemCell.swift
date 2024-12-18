//
//  MenuItemCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 17.12.2024.
//

import UIKit
import SnapKit
import SDWebImage

class MenuItemCell: UICollectionViewCell {

    static let reusableId = "MenuItemCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 16)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 16)
        label.textColor = AppColors.main
        return label
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 14)
        label.textColor = AppColors.grayForTextCell
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(itemImageView)
        contentView.addSubview(descriptionLabel)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        
        // Устанавливаем ограничения
        itemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(110)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalTo(itemImageView.snp.left).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel)
            make.bottom.equalToSuperview().offset(-25)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(itemImageView.snp.left).offset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with menuItem: MenuItem) {
        nameLabel.text = menuItem.name
        priceLabel.text = "\(menuItem.price)₴"
        descriptionLabel.text = menuItem.description
        if let url = URL(string: menuItem.imageUrl) {
            itemImageView.sd_setImage(with: url)
        }
    }
}
