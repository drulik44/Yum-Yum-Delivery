//
//  FoodItemCell.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.01.2025.
//

import UIKit

class FoodItemCell: UITableViewCell {
    
    static let identifier = "FoodItemCell"
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 20)
        label.textColor = AppColors.topographyHome
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private lazy var deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Init & Layout
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        self.backgroundColor = AppColors.background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(deliveryTimeLabel)
        
        foodImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.top.equalTo(contentView).offset(8)
            make.width.height.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(foodImageView.snp.right).offset(12)
            make.right.equalTo(contentView).inset(16)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        
        deliveryTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(ratingLabel.snp.bottom).offset(4)
        }
    }
    
    // MARK: - Configure
    func configure(with foodItem: FoodItem) {
        nameLabel.text = foodItem.name
        ratingLabel.text = "Rating: \(foodItem.rating)"
        deliveryTimeLabel.text = "Delivery: \(foodItem.deliveryTime)"
        
        // Загрузка изображения
        if let imageUrl = URL(string: foodItem.imageUrl) {
            // Используйте библиотеку типа `SDWebImage` для загрузки изображения
            foodImageView.loadImage(from: imageUrl)
        }
    }
}

// MARK: - UIImageView extension for loading image
extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
