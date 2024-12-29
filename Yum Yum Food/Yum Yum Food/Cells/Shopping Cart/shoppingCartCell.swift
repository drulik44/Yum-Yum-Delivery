//
//  shoppingCartCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 29.12.2024.
//

import UIKit
import SnapKit
import SDWebImage

class ShoppingCartCell: UICollectionViewCell {

    static let reusableId = "ShoppingCartCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 16)
        label.numberOfLines = 3
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

    private let incrementDecrementView: IncrementDecrementView = {
        let view = IncrementDecrementView()
        view.layer.cornerRadius = 20
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(itemImageView)
        contentView.addSubview(incrementDecrementView)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        
        

        itemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(itemImageView.snp.right).offset(20)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(itemImageView.snp.right).offset(20)
        }

        incrementDecrementView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(110)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with cartItem: CartItem) {
        nameLabel.text = cartItem.menuItem.name
        priceLabel.text = "\(cartItem.finalPrice)0₴"
        if let url = URL(string: cartItem.menuItem.imageUrl) {
            itemImageView.sd_setImage(with: url, completed: nil)
        }
        incrementDecrementView.quantity = cartItem.quantity
    }
}
