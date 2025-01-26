//
//  OrderCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 31.12.2024.
//

import UIKit
import SnapKit
import SDWebImage

class OrderCell: UICollectionViewCell {
    
    static let reusableId = "OrderCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 16)
        label.numberOfLines = 0 // Разрешить несколько строк
        return label
    }()

    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 16)
        label.textColor = AppColors.main
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 14)
        label.textColor = AppColors.gray
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(totalPriceLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(dateLabel)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = AppColors.background

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(100)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(imageView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(imageView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(5)
            make.left.equalTo(imageView.snp.right).offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with order: Order) {
        nameLabel.text = order.name.localized()
        totalPriceLabel.text = "\(order.totalPrice)₴"
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateLabel.text = dateFormatter.string(from: order.date)
        
        if let url = URL(string: order.imageUrl) {
            imageView.sd_setImage(with: url, completed: nil)
        }
    }
}
