//
//  FoodDetailsViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 19.12.2024.
//

import UIKit
import SnapKit
import SDWebImage


class FoodDetailsViewController: UIViewController {
    weak var coordinator: RestaurantsCoordinator?
    var menuItem: MenuItem?
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.background
        setupUI()
        setupConstraints()
        configureView()
        
        likeButtonFood.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        likeButtonFood.backgroundColor = .clear
        selectedButton.addTarget(self, action: #selector(selectedButtonTapped) , for: .touchUpInside)
    }
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let foodTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of:25)
        label.textColor = AppColors.topographyHome
        label.numberOfLines = 0
        return label
    }()
    
    private let likeButtonFood: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite 2"), for: .normal)
        button.tintColor = AppColors.gray
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
    private let foodDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of:16)
        label.textColor = AppColors.grayForTextCell
        label.numberOfLines = 0
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    private let foodPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of:18)
        label.textColor = AppColors.main
        return label
    }()
    
    //MARK: - Package
    
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
    
    
    private let bottomPanel: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to order", for: .normal)
        button.titleLabel?.font = .Rubick.bold.size(of:18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.main
        button.layer.cornerRadius = 25
        return button
    }()
    
    private let selectedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle" ), for: .normal)
        button.tintColor = AppColors.main
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let incrementDecrementView = IncrementDecrementView()
    
    
   
    
    
// MARK: - Setup UI
    private func setupUI(){
        view.addSubview(foodImageView)
        view.addSubview(foodTitleLabel)
        view.addSubview(likeButtonFood)
        view.addSubview(foodDescriptionLabel)
        view.addSubview(foodPriceLabel)
        view.addSubview(packageLabel)
        view.addSubview(packageIcon)
        view.addSubview(costLabel)
        view.addSubview(priceLabel)
        view.addSubview(selectedButton)
        
        
        view.addSubview(bottomPanel)
        
        

        
        
        bottomPanel.addSubview(addToCartButton)
        bottomPanel.addSubview(incrementDecrementView)
    }
    
    //MARK: - setupConstraints
     private func setupConstraints(){
         
         foodImageView.translatesAutoresizingMaskIntoConstraints = false
         foodTitleLabel.translatesAutoresizingMaskIntoConstraints = false
         foodDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
         foodPriceLabel.translatesAutoresizingMaskIntoConstraints = false
         
         foodImageView.snp.makeConstraints { make in
             make.top.equalToSuperview()
             make.width.equalToSuperview()
             make.height.equalTo(350)
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
    
    //MARK: -configureView

    private func configureView(){
        
        guard let menuItem else { return }
        
        foodTitleLabel.text = menuItem.name
        foodDescriptionLabel.text = menuItem.description
        foodPriceLabel.text = "\(menuItem.price)₴"
        
        if let url = URL(string: menuItem.imageUrl) {
            foodImageView.sd_setImage(with: url, completed: nil)
        }else {
            print("Invalid URL: \(menuItem.imageUrl)")
        }
    }
    
    
    //MARK: - Objc func
    @objc private func didTapLikeButton() {
        likeButtonFood.isSelected.toggle()
        
        guard let menuItem = menuItem else { return }
        
        let favoriteItem = FavoriteItem(id: menuItem.id,
                                        name: menuItem.name,
                                        description: menuItem.description,
                                        imageUrl: menuItem.imageUrl,
                                        price: menuItem.price,
                                        rating: 0,
                                        deliveryTime: "",
                                        deliveryPrice: "",
                                        type: .food)
        
        if likeButtonFood.isSelected {
            likeButtonFood.setImage(UIImage(named: "favorite tapped"), for: .normal)
            likeButtonFood.tintColor = AppColors.main
            FavoritesManager.shared.addToFavorites(item: favoriteItem)
        } else {
            likeButtonFood.setImage(UIImage(named: "favorite 2"), for: .normal)
            likeButtonFood.tintColor = AppColors.gray
            FavoritesManager.shared.removeFromFavorites(item: favoriteItem)
        }
    }

    
    @objc private func selectedButtonTapped() {
        selectedButton.isSelected.toggle()
        if selectedButton.isSelected {
            selectedButton.setImage(UIImage(systemName: "record.circle.fill" ), for: .normal)
            selectedButton.tintColor = AppColors.main
        } else {
            selectedButton.setImage(UIImage(systemName: "circle"), for: .normal)
            selectedButton.tintColor = AppColors.main
        }
    }
   
    
    //MARK: - Collection
    
    
}
