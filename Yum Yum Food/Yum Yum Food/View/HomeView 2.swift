//
//  HomeView 2.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.01.2025.
//


import UIKit
import SnapKit

class HomeView: UIView {
    let customAddressView = CustomAddressView()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let bannerImageView = UIImageView(image: UIImage(named: "banner 1"))
    let fastestDeliveryLabel = UILabel()
    let popularItemsLabel = UILabel()
    let fastestDeliveryCollectionView: UICollectionView
    let popularItemsCollectionView: UICollectionView
    let seeAllButton = CustomButton()

    override init(frame: CGRect) {
        let fastestLayout = UICollectionViewFlowLayout()
        fastestLayout.scrollDirection = .horizontal
        fastestDeliveryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: fastestLayout)

        let popularLayout = UICollectionViewFlowLayout()
        popularLayout.scrollDirection = .horizontal
        popularItemsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: popularLayout)

        super.init(frame: frame)

        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        // Add subviews to contentView
        contentView.addSubview(customAddressView)
        contentView.addSubview(bannerImageView)
        contentView.addSubview(fastestDeliveryLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(fastestDeliveryCollectionView)
        contentView.addSubview(popularItemsLabel)
        contentView.addSubview(popularItemsCollectionView)

        fastestDeliveryLabel.font = .Rubick.bold.size(of: 20)
        popularItemsLabel.font = .Rubick.bold.size(of: 20)

        fastestDeliveryCollectionView.backgroundColor = .clear
        popularItemsCollectionView.backgroundColor = .clear
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
        contentView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
