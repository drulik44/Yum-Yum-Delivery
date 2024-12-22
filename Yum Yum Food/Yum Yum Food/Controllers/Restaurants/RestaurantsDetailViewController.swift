//
//  RestaurantsDetailViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 14.12.2024.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore
import SDWebImage

class RestaurantDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    weak var coordinator: RestaurantsCoordinator?
    var restaurant: Restaurant?
    private let db = Firestore.firestore()
    private var menuItems: [MenuItem] = []

    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()



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
        let button = UIButton()
        button.setImage(UIImage(named: "favorite 2"), for: .normal)
        button.tintColor = AppColors.gray
        button.contentMode = .scaleAspectFit
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
    
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.font = .Rubick.bold.size(of:25)
        label.textColor = AppColors.topographyHome
        label.text = "Menu"
        return label
    }()
    
    //MARK: - Colection Menu
    
    private let menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        return collectionView
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
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        likeButton.backgroundColor = .clear
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.isScrollEnabled = false
        scrollView.contentInsetAdjustmentBehavior = .never




        
        
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(restaurantImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(ratingImageView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(deliveryTimeImage)
        contentView.addSubview(deliveryTimeLabel)
        contentView.addSubview(deliverImage)
        contentView.addSubview(deliveryPriceLabel)
        contentView.addSubview(menuLabel)
        contentView.addSubview(menuCollectionView)
    }
    
    
    //MARK: - Setup Constraints
    private func setupConstraints() {
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1700)
        }
        
        restaurantImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).priority(.high)
            make.top.equalTo(scrollView.snp.top).priority(.low) // Фиксирует наверху скролла
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
            make.height.equalTo(50)
            make.width.equalTo(50)
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
        menuLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryPriceLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview().inset(16)
        }


        
        
        
    }
    
    private func configureView() {
        guard let restaurant = restaurant else { return }

        // Устанавливаем данные для ресторана
        if let url = URL(string: restaurant.imageUrl) {
            restaurantImageView.sd_setImage(with: url, completed: nil)
        } else {
            print("Invalid URL: \(restaurant.imageUrl)")
        }
        
        nameLabel.text = restaurant.name
        descriptionLabel.text = restaurant.description
        ratingLabel.text = "Rating: \(restaurant.rating)"
        deliveryTimeLabel.text = "Delivery Time: \(restaurant.deliveryTime)"
        deliveryPriceLabel.text = "Delivery Price: \(restaurant.deliveryPrice) "

        // Загружаем меню из Firestore
        db.collection("restaurants").document(restaurant.id).collection("menu_items").getDocuments(source: .server) { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error fetching menu: \(error)")
            } else {
                self?.menuItems = querySnapshot?.documents.compactMap { document in
                    let data = document.data()
                    let id = document.documentID
                    let name = data["name"] as? String ?? ""
                    let price = data["price"] as? String ?? ""
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    
                    return MenuItem(id: id, name: name, price: price, imageUrl: imageUrl, description: description)
                } ?? []
                self?.menuCollectionView.reloadData()
            }
        }


    }

    
    
    

    @objc private func didTapLikeButton() {
        likeButton.isSelected.toggle()
        
        guard let restaurant = restaurant else { return }
        
        let favoriteItem = FavoriteItem(id: restaurant.id,
                                        name: restaurant.name,
                                        description: restaurant.description,
                                        imageUrl: restaurant.imageUrl,
                                        price: "",
                                        rating: restaurant.rating,
                                        deliveryTime: restaurant.deliveryTime,
                                        deliveryPrice: restaurant.deliveryPrice,
                                        type: .restaurant)
        
        if likeButton.isSelected {
            likeButton.setImage(UIImage(named: "favorite tapped"), for: .normal)
            likeButton.tintColor = AppColors.main
            FavoritesManager.shared.addToFavorites(item: favoriteItem)
        } else {
            likeButton.setImage(UIImage(named: "favorite 2"), for: .normal)
            likeButton.tintColor = AppColors.gray
            FavoritesManager.shared.removeFromFavorites(item: favoriteItem)
        }
    }
    
    
    //MARK: - UICollectionData and Delegate

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return menuItems.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as! MenuItemCell
            let menuItem = menuItems[indexPath.item]
            cell.configure(with: menuItem)
            return cell
        }
    
    //MARK: - TAPPED FUNC
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMenuItem = menuItems[indexPath.item]
        print("Selected menu item: \(selectedMenuItem.name)") // Печатает название выбранного пункта
        showFoodDetail(with: selectedMenuItem)
        
    }

    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width - 10, height: 160) // Установите подходящий размер
        }
    
    
    //MARK: - Func Show FoodDetail Controller
    func showFoodDetail(with menuItem: MenuItem) {
        let foodVC = FoodDetailsViewController()
        foodVC.menuItem = menuItem // Передача данных
        foodVC.modalPresentationStyle = .formSheet
        present(foodVC, animated: true)
    }

    
}
