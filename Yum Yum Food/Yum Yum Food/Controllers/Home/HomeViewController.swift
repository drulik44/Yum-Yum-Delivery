//
//  HomeViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import FirebaseFirestore
import SnapKit

class HomeViewController: UIViewController {
    weak var coordinator: HomeCoordinator?
    private let customAddressView = CustomAddressView()
    private let db = Firestore.firestore()
    private var fastestDeliveryItems: [FoodItem] = []
    private var popularItems: [FoodItem] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.background
        setupUI()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDeliveryAddressVC))
        customAddressView.addGestureRecognizer(tapGesture)
        customAddressView.isUserInteractionEnabled = true
        
        fetchFastestDelivery()
        fetchPopularItems()
    }
    
    // MARK: - UI Elements
    
    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner 1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let fastestDeliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Fastest delivery 🔥"
        label.font = .Rubick.bold.size(of: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    private let fastestDeliveryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(FastestDeliveryCell.self, forCellWithReuseIdentifier: FastestDeliveryCell.reusableId)
        return collectionView
    }()
    
    private let popularItemsLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular items 🥳"
        label.font = .Rubick.bold.size(of: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.4
        label.layer.shadowOffset = CGSize(width: 2, height: 4)
        label.layer.shadowRadius = 4
        return label
    }()
    
    private let popularItemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(PopularItemsCell.self, forCellWithReuseIdentifier: PopularItemsCell.reusableId)
        return collectionView
    }()
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(customAddressView)
        contentView.addSubview(bannerImageView)
        contentView.addSubview(fastestDeliveryLabel)
        contentView.addSubview(fastestDeliveryCollectionView)
        contentView.addSubview(popularItemsLabel)
        contentView.addSubview(popularItemsCollectionView)
        
        fastestDeliveryCollectionView.dataSource = self
        fastestDeliveryCollectionView.delegate = self
        popularItemsCollectionView.dataSource = self
        popularItemsCollectionView.delegate = self
        
       
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        customAddressView.snp.makeConstraints { make in
           // make.top.equalTo(contentView.snp.top).offset(70)
            make.top.equalTo(contentView.snp.top).offset(-15) // Изменим отступ
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(70)
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.top.equalTo(customAddressView.snp.bottom).offset(10)
            make.height.equalTo(190)
            make.width.equalTo(350)
            make.centerX.equalToSuperview()
        }
        
        fastestDeliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(bannerImageView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }
        
        fastestDeliveryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(fastestDeliveryLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(210)
        }
        
        popularItemsLabel.snp.makeConstraints { make in
            make.top.equalTo(fastestDeliveryCollectionView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        popularItemsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(popularItemsLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(210)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @objc private func openDeliveryAddressVC() {
        let deliveryVC = DeliveryAddressWithMapViewController()
        
        deliveryVC.addressCompletion = { [weak self] address in
            self?.customAddressView.addressLabel.text = address
        }
        
        navigationController?.pushViewController(deliveryVC, animated: true)
    }
    
    // MARK: - Fetch Data from Firestore
    
    private func fetchFastestDelivery() {
        db.collection("fastest_delivery").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                self?.fastestDeliveryItems = querySnapshot?.documents.compactMap { document in
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let rating = data["rating"] as? Double ?? 0.0
                    let deliveryTime = data["deliveryTime"] as? String ?? ""
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    let deliveryPrice = data["deliveryPrice"] as? Double ?? 0.0
                    let description = data["description"] as? String ?? ""
                    return FoodItem(name: name, rating: rating, deliveryTime: deliveryTime, imageUrl: imageUrl, deliveryPrice: deliveryPrice , description: description)
                } ?? []
                self?.fastestDeliveryCollectionView.reloadData()
            }
        }
    }
    
    private func fetchPopularItems() {
        db.collection("popular_items").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
            } else {
                self?.popularItems = querySnapshot?.documents.compactMap { document in
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let rating = data["rating"] as? Double ?? 0.0
                    let deliveryTime = data["deliveryTime"] as? String ?? ""
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    let deliveryPrice = data["deliveryPrice"] as? Double ?? 0.0
                    let description = data["description"] as? String ?? ""
                    return FoodItem(name: name, rating: rating, deliveryTime: deliveryTime, imageUrl: imageUrl, deliveryPrice: deliveryPrice, description: description )
                } ?? []
                self?.popularItemsCollectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == fastestDeliveryCollectionView {
            return fastestDeliveryItems.count
        } else {
            return popularItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == fastestDeliveryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FastestDeliveryCell.reusableId, for: indexPath) as! FastestDeliveryCell
            cell.data = fastestDeliveryItems[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularItemsCell.reusableId, for: indexPath) as! PopularItemsCell
            cell.data = popularItems[indexPath.item]
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 270, height: 210)
    }
}

