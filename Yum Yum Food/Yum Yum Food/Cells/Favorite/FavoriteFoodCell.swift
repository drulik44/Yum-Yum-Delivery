//
//  FavoriteFoodCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 21.12.2024.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

protocol FavoriteFoodCellDelegate: AnyObject {
    func didTapLikeButton(on cell: FavoriteFoodCell)
}
class FavoriteFoodCell: UICollectionViewCell {

    
    weak var delegate: FavoriteFoodCellDelegate?
    
    static let reusableId = "FavoriteFoodCell"
    
    private let FoodImageView: UIImageView = {
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
    
    private let priceView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wallet-2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of:14)
        label.textColor = AppColors.topographyHome
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite tapped"), for: .normal)
        button.tintColor = AppColors.main
        button.layer.zPosition = 1 // Установите приоритет z-индекса
        return button
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
        contentView.addSubview(FoodImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        FoodImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(170)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(FoodImageView.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(16)
        }

        priceView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(16)
        }

        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(priceView)
            make.left.equalTo(priceView.snp.right).offset(8)
        }
        
        // Констрейнты для кнопки "like"
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.width.height.equalTo(24)
        }
    }
    
    func configure(with favoriteItem: FavoriteItem) {
        nameLabel.text = favoriteItem.name
        priceLabel.text = "\(favoriteItem.price)₴"
        descriptionLabel.text = favoriteItem.description
            
        if let url = URL(string: favoriteItem.imageUrl) {
            FoodImageView.sd_setImage(with: url, completed: nil)
        } else {
            FoodImageView.image = UIImage(named: "defaultImage")
        }
    }
    
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton(on: self)
    }

}
