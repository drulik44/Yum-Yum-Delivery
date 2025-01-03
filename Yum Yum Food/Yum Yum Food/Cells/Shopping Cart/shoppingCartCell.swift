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
    weak var delegate: ShoppingCartCellDelegate?
    var cartItem: CartItem? 
    static let reusableId = "ShoppingCartCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 16)
        label.numberOfLines = 3
        return label
    }()
    
    private let removeButton: UIButton = {
           let button = UIButton()
           button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
           button.tintColor = AppColors.main
           return button
       }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 16)
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
        contentView.addSubview(removeButton)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = AppColors.background
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)

        
        

        itemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(itemImageView.snp.right).offset(20)
            make.right.equalTo(removeButton.snp.left).offset(-5)
        }
        
        removeButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-5)
            make.height.width.equalTo(40)
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
        incrementDecrementView.onIncrement = { [weak self] in
            guard let self = self, let item = self.cartItem else { return }
            self.delegate?.didUpdateQuantity(for: item, quantity: self.incrementDecrementView.quantity)
        }

        incrementDecrementView.onDecrement = { [weak self] in
            guard let self = self, let item = self.cartItem else { return }
            self.delegate?.didUpdateQuantity(for: item, quantity: self.incrementDecrementView.quantity)
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func removeButtonTapped(){
        guard let item = cartItem else { return }
                delegate?.didRemoveItem(item)
    }

    func configure(with cartItem: CartItem) {
        self.cartItem = cartItem
        nameLabel.text = cartItem.menuItem.name
        priceLabel.text = "\(cartItem.finalPrice)₴"
        incrementDecrementView.quantity = cartItem.quantity

        if let url = URL(string: cartItem.menuItem.imageUrl) {
            itemImageView.sd_setImage(with: url, completed: nil)
        }
        print("Configured cell for \(cartItem.menuItem.name), quantity: \(cartItem.quantity)") // Проверка
    }

}
