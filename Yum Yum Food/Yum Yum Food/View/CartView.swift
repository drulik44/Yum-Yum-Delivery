//
//  CartView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 25.01.2025.
//

import UIKit
import SnapKit

class CartView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 24)
        label.text = "Order items".localized()
        return label
    }()
    
    let shoppingCartView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(ShoppingCartCell.self, forCellWithReuseIdentifier: ShoppingCartCell.reusableId)
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")
        return collectionView
    }()
    
    let checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout".localized(), for: .normal)
        button.setTitleColor(AppColors.backgroundCell, for: .normal)
        button.titleLabel?.font = .Rubick.bold.size(of: 24)
        button.backgroundColor = AppColors.main
        button.layer.cornerRadius = 24
        return button
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = AppColors.main
        view.hidesWhenStopped = true
        return view
    }()
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.isHidden = true
        return view
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
        addSubview(titleLabel)
        addSubview(shoppingCartView)
        addSubview(indicatorView)
        addSubview(overlayView)
        addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        shoppingCartView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(checkoutButton.snp.top).offset(-20)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}
