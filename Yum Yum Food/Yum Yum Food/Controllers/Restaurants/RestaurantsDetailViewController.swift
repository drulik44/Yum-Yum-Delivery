//
//  RestaurantsDetailViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 14.12.2024.
//

import UIKit
import SnapKit
import SDWebImage

class RestaurantDetailViewController: UIViewController {
    weak var coordinator: RestaurantsCoordinator?
    var restaurant: Restaurant?
    
    private let restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of: 30)
        label.textColor = AppColors.topographyHome
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Favorite"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of:18)
        label.textColor = AppColors.grayForTextCell
        label.numberOfLines = 0
        
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    private let ratingImageView: UIImageView = {
        let imageView = UIImageView()
        
        if let originalImage = UIImage(named: "rate") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintedImage
        }
        imageView.tintColor = AppColors.main
        return imageView
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of:16)
        label.textColor = AppColors.grayForTextCell
        
        return label
    }()
    
    private let deliveryTimeImage: UIImageView = {
        let imageView = UIImageView()
        if let originalImage = UIImage(named: "time") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintedImage
        }
        imageView.tintColor = AppColors.main

        return imageView
    }()
    
    private let deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.regular.size(of:16)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    
    private let deliverImage: UIImageView = {
        let imageView = UIImageView()
        if let originalImage = UIImage(named: "delivery track") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
            imageView.image = tintedImage
        }
        imageView.tintColor = AppColors.main

        return imageView
    }()
    
    private let deliveryPriceLabel: UILabel = {
       let label = UILabel()
        label.font = .Rubick.regular.size(of:16)
        label.textColor = AppColors.grayForTextCell
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupCustomBackButton(for: self)

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        setupUI()
        setupConstraints()
        configureView()
        navigationController?.setupCustomBackButton(for: self)

    }
    
    private func setupUI() {
        view.addSubview(restaurantImageView)
        view.addSubview(nameLabel)
        view.addSubview(likeButton)
        view.addSubview(descriptionLabel)
        view.addSubview(ratingImageView)
        view.addSubview(ratingLabel)
        view.addSubview(deliveryTimeImage)
        view.addSubview(deliveryTimeLabel)
        view.addSubview(deliverImage)
        view.addSubview(deliveryPriceLabel)
    }
    
    
    //MARK: - Setup Constraints
    private func setupConstraints() {
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        restaurantImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalToSuperview()
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantImageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        ratingImageView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ratingImageView)
            make.left.equalTo(ratingImageView.snp.right).offset(4)
        }
        deliveryTimeImage.snp.makeConstraints { make in
            make.top.equalTo(ratingImageView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        deliveryTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliveryTimeImage)
            make.left.equalTo(deliveryTimeImage.snp.right).offset(4)
        }
        deliverImage.snp.makeConstraints { make in
            make.top.equalTo(deliveryTimeLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        deliveryPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deliverImage)
            make.left.equalTo(deliverImage.snp.right).offset(4)
        }
        
        
        
    }
    
    private func configureView() {
        guard let restaurant = restaurant else { return }

        if let url = URL(string: restaurant.imageUrl) {
            restaurantImageView.sd_setImage(with: url, completed: nil)
        } else {
            print("Invalid URL: \(restaurant.imageUrl)")
        }

        nameLabel.text = restaurant.name
        descriptionLabel.text = restaurant.description
        ratingLabel.text = "\(restaurant.rating)"
        deliveryTimeLabel.text = "Delivery Time: \(restaurant.deliveryTime)"
        deliveryPriceLabel.text = "Delivery Price: \(restaurant.deliveryPrice)"
    }


    
    @objc private func didTapLikeButton() {
        likeButton.isSelected.toggle()
        if likeButton.isSelected {
            likeButton.setImage(UIImage(named: "Favorite"), for: .normal)
            likeButton.tintColor = AppColors.main
        } else {
            likeButton.setImage(UIImage(named: "Favorite"), for: .normal)
            likeButton.tintColor = .gray
        } // Анимация перехода
        UIView.transition(with: likeButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.likeButton.layoutIfNeeded()
        }, completion: nil)
    }
}
