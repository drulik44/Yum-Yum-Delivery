//
//  FoodDetailsView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.01.2025.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class FoodDetailsView: UIView {
    let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let foodTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 25)
        label.textColor = AppColors.topographyHome
        label.numberOfLines = 0
        return label
    }()
    
    let likeButtonFood: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite 2"), for: .normal)
        button.tintColor = AppColors.gray
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let foodDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of: 16)
        label.textColor = AppColors.grayForTextCell
        label.numberOfLines = 0
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    let foodPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 18)
        label.textColor = AppColors.main
        return label
    }()
    
    let packageLabel: UILabel = {
        let label = UILabel()
        label.text = "Package".localized()
        label.font = .Rubick.bold.size(of: 20)
        label.textColor = AppColors.topographyHome
        return label
    }()
    
    let packageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Custom Color Package 2 Icon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let costLabel: UILabel = {
        let label = UILabel()
        label.text = "Package box cost".localized()
        label.font = .Rubick.regular.size(of: 16)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "20,0 ₴"
        label.font = .Rubick.regular.size(of: 16)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    let bottomPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to order".localized(), for: .normal)
        button.titleLabel?.font = .Rubick.bold.size(of: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.main
        button.layer.cornerRadius = 25
        return button
    }()
    
    let selectedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = AppColors.main
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let incrementDecrementView = IncrementDecrementView()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.darkGray
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.zPosition = 1
        return button
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
        addSubview(foodImageView)
        addSubview(closeButton)
        addSubview(foodTitleLabel)
        addSubview(likeButtonFood)
        addSubview(foodDescriptionLabel)
        addSubview(foodPriceLabel)
        addSubview(packageLabel)
        addSubview(packageIcon)
        addSubview(costLabel)
        addSubview(priceLabel)
        addSubview(selectedButton)
        addSubview(bottomPanel)
        bottomPanel.addSubview(addToCartButton)
        bottomPanel.addSubview(incrementDecrementView)
    }
    
    private func setupConstraints() {
        foodImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(350)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(40)
        }
        
        foodTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-80)
        }
        
        likeButtonFood.snp.makeConstraints { make in
            make.centerY.equalTo(foodTitleLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        foodDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(foodTitleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        foodPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(foodDescriptionLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        packageLabel.snp.makeConstraints { make in
            make.top.equalTo(foodPriceLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        packageIcon.snp.makeConstraints { make in
            make.top.equalTo(packageLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
        }
        
        costLabel.snp.makeConstraints { make in
            make.centerY.equalTo(packageIcon)
            make.left.equalTo(packageIcon.snp.right).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(packageIcon)
            make.left.equalTo(costLabel.snp.right).offset(90)
        }
        
        selectedButton.snp.makeConstraints { make in
            make.centerY.equalTo(priceLabel)
            make.right.equalToSuperview().offset(-20)
        }
        
        bottomPanel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(170)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
        }
        
        incrementDecrementView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(25)
            make.height.equalTo(50)
            make.width.equalTo(130)
        }
    }
    
    func configure(with menuItem: MenuItem) {
        foodTitleLabel.text = menuItem.name.localized()
        foodDescriptionLabel.text = menuItem.description.localized()
        foodPriceLabel.text = "\(menuItem.price)₴"
        
        if let url = URL(string: menuItem.imageUrl) {
            foodImageView.sd_setImage(with: url, completed: nil)
        } else {
            print("Invalid URL: \(menuItem.imageUrl)")
        }
    }
}
