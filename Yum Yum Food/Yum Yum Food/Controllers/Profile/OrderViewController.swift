//
//  OrderViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.12.2024.
//

import UIKit

class OrderViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var orders: [Order] = []

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = AppColors.background
        collectionView.register(OrderCell.self, forCellWithReuseIdentifier: OrderCell.reusableId)
        return collectionView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 24)
        label.textAlignment = .center
        label.text = "My Orders".localized()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadOrders()
    }

    private func setupUI() {
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(20)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
        }
    }

    private func loadOrders() {
        orders = OrdersManager.shared.getOrders()
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCell.reusableId, for: indexPath) as? OrderCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: orders[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 130)
    }
}


    

