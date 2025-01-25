//
//  HomeViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit

class HomeViewController: UIViewController {
    weak var coordinator: HomeCoordinator?
    
    private let homeView = HomeView()
    private let homeModel = HomeModel()
    
    private var fastestDeliveryItems: [FoodItem] = []
    private var popularItems: [FoodItem] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.background
        view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDeliveryAddressVC))
        homeView.customAddressView.addGestureRecognizer(tapGesture)
        homeView.customAddressView.isUserInteractionEnabled = true
        
        homeView.fastestDeliveryCollectionView.dataSource = self
        homeView.fastestDeliveryCollectionView.delegate = self
        homeView.popularItemsCollectionView.dataSource = self
        homeView.popularItemsCollectionView.delegate = self
        
        homeView.seeAllButton.addTarget(self, action: #selector(didTapFastestDeliveryButton), for: .touchUpInside)
        
        fetchFastestDelivery()
        fetchPopularItems()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .init("LanguageChanged"), object: nil)
        updateUI()
    }
    
    @objc private func openDeliveryAddressVC() {
        let deliveryVC = DeliveryAddressWithMapViewController()
        deliveryVC.addressCompletion = { [weak self] address in
            self?.homeView.customAddressView.addressLabel.text = address
        }
        navigationController?.pushViewController(deliveryVC, animated: true)
    }
    
    private func fetchFastestDelivery() {
        homeModel.fetchFastestDelivery { [weak self] items in
            self?.fastestDeliveryItems = items
            self?.homeView.fastestDeliveryCollectionView.reloadData()
        }
    }
    
    private func fetchPopularItems() {
        homeModel.fetchPopularItems { [weak self] items in
            self?.popularItems = items
            self?.homeView.popularItemsCollectionView.reloadData()
        }
    }
    
    @objc private func didTapFastestDeliveryButton() {
        coordinator?.showFastestDelivery()
    }
    
    @objc func updateUI() {
        homeView.fastestDeliveryLabel.text = "Fastest delivery 🔥".localized()
        homeView.popularItemsLabel.text = "Popular items 🥳".localized()
        homeView.fastestDeliveryCollectionView.reloadData()
        homeView.popularItemsCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeView.fastestDeliveryCollectionView {
            return fastestDeliveryItems.count
        } else {
            return popularItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeView.fastestDeliveryCollectionView {
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
        if collectionView == homeView.fastestDeliveryCollectionView {
            return CGSize(width: 270, height: 210)
        } else if collectionView == homeView.popularItemsCollectionView {
            return CGSize(width: 170, height: 200)
        }
        return CGSize(width: 0, height: 0)
    }
}
