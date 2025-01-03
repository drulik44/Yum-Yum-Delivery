//
//  FastestDeliveryViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.01.2025.
//

import UIKit
import SnapKit
import FirebaseFirestore
import Firebase

class FastestDeliveryViewController: UIViewController {
    weak var coordinator: HomeCoordinator?
    
    private let db = Firestore.firestore()
    private var fastestDeliveryItems: [FoodItem] = []

    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 24)
        label.textAlignment = .center
        label.text = "Fastest delivery 🔥"
        return label
    }()
    lazy var FastestCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = AppColors.background
        collectionView.register(FastestDeliveryCell.self, forCellWithReuseIdentifier: FastestDeliveryCell.reusableId)
        return collectionView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false

        navigationController?.setupCustomBackButton(for: self)
        
        setupUI()
        setupConstraints()
        fetchFastestDelivery()
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = AppColors.background
        view.addSubview(scrollView)
        FastestCollectionView.isScrollEnabled = false

        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(FastestCollectionView)
        
        FastestCollectionView.delegate = self
        FastestCollectionView.dataSource = self
    }

    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView) // Ширина должна совпадать с шириной экрана
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        FastestCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1000) // Укажите фиксированную высоту или измените в зависимости от контента
            make.bottom.equalToSuperview().offset(-20) // Убедитесь, что контент завершает contentView
        }
    }

    
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
                    let deliveryPrice = data["deliveryPrice"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    return FoodItem(name: name, rating: rating, deliveryTime: deliveryTime, imageUrl: imageUrl, deliveryPrice: deliveryPrice , description: description, nameRestaurant: "", price: "")
                } ?? []
                self?.FastestCollectionView.reloadData()
            }
        }
    }
}

extension FastestDeliveryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == FastestCollectionView {
            return fastestDeliveryItems.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == FastestCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FastestDeliveryCell.reusableId, for: indexPath) as! FastestDeliveryCell
            cell.data = fastestDeliveryItems[indexPath.item]
            return cell // Исправлено: return
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == FastestCollectionView {
            // Размер для ячеек в fastestDeliveryCollectionView
            return CGSize(width: 350, height: 210)
        }
        return CGSize(width: 0, height: 0) // Значение по умолчанию (может быть не достигнуто)

    }
}
