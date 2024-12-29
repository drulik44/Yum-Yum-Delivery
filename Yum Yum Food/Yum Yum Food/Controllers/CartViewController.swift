//
//  CartViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 26.12.2024.
//

import UIKit
import SnapKit

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    weak var coordinator: MainCoordinator?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 24)
        label.text = "Order items"
        return label
    }()

    private let shoppingCartView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ShoppingCartCell.self, forCellWithReuseIdentifier: ShoppingCartCell.reusableId)
        return collectionView
    }()

    private var cartItems: [CartItem] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupCustomBackButton(for: self)
        navigationItem.title = "Your order"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        cartItems = CartManager.shared.getCartItems()
        shoppingCartView.dataSource = self
        shoppingCartView.delegate = self
    }

    private func setupUI() {
        view.backgroundColor = AppColors.background
        view.addSubview(titleLabel)
        view.addSubview(shoppingCartView)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.left.equalToSuperview().offset(20)
        }

        shoppingCartView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}

extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCartCell.reusableId, for: indexPath) as? ShoppingCartCell else {
            return UICollectionViewCell()
        }
        let cartItem = cartItems[indexPath.row]
        cell.configure(with: cartItem)
        return cell
    }
    
   
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width - 10, height: 120)  // Размеры ячеек
        }
    }


