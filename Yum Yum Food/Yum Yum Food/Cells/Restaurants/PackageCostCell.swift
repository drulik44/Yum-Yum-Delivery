//
//  PackageCostCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 20.12.2024.
//

import UIKit
import SnapKit

class PackageCostCell: UICollectionViewCell {
    
    
    private let packageLabel: UILabel = {
        let label = UILabel()
        label.text = "Package"
        label.font = .Rubick.bold.size(of: 20)
        label.textColor = AppColors.topographyHome
        return label
    }()
    
    private let packageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Custom Color Package 2 Icon") // Замените на ваше изображение
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let costLabel: UILabel = {
        let label = UILabel()
        label.text = "Package box cost"
        label.font = .Rubick.regular.size(of: 16)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "20,0 ₴"
        label.font = .Rubick.regular.size(of: 16)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = AppColors.main
        return imageView
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
        contentView.addSubview(packageLabel)
        contentView.addSubview(packageIcon)
        contentView.addSubview(costLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(iconView)
    }
    
    private func setupConstraints() {
        packageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        packageIcon.snp.makeConstraints { make in
            make.top.equalTo(packageLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(20)
        }
        
        costLabel.snp.makeConstraints { make in
            make.centerY.equalTo(packageIcon)
            make.left.equalTo(packageIcon.snp.right).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(packageIcon)
            make.left.equalTo(costLabel.snp.right).offset(10)
        }
        
        iconView.snp.makeConstraints { make in
            make.centerY.equalTo(packageIcon)
            make.left.equalTo(priceLabel.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(20)
        }
    }
    
    func updateIcon(isSelected: Bool) {
        iconView.image = UIImage(systemName: isSelected ? "record.circle.fill" : "circle")
        iconView.tintColor = AppColors.main
    }
}
