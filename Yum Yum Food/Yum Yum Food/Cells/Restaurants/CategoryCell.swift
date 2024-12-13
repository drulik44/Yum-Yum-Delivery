//
//  CategoryCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 11.12.2024.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 13)
        label.textColor = AppColors.topographyHome
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        
        // Устанавливаем фоновый цвет для ячейки
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(100) 
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo(contentView)
            make.height.equalTo(20)
        }
    }
    
    func configure(with name: String, imageName: String) {
        nameLabel.text = name
        imageView.image = UIImage(named: imageName)
    }
}
