//
//  FavoriteViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import SnapKit

class FavoriteViewController: UIViewController {
    weak var coordinator: FavoriteCoordinator?
    
    private var favoriteFoodItems: [FavoriteItem] = []
    private var favoriteRestaurantItems: [FavoriteItem] = []
    
    let segmentedControl: CustomSegmentedControl = {
        let items = ["Food", "Restaurants"]
        let sc = CustomSegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: AppColors.textColorMain,
            .font: UIFont.Rubick.bold.size(of: 17)
        ]
        sc.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        let normalTextAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: AppColors.textColorMain,
            .font: UIFont.Rubick.regular.size(of: 16)
        ]
        sc.setTitleTextAttributes(normalTextAttributes, for: .normal)
        
        return sc
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FavoriteFoodCell.self, forCellWithReuseIdentifier: FavoriteFoodCell.reusableId)
        collectionView.register(FavoriteRestaurantCell.self, forCellWithReuseIdentifier: FavoriteRestaurantCell.reusableId)
        collectionView.backgroundColor = AppColors.background
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        loadFavoriteItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupCollectionView()
        loadFavoriteItems()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = AppColors.background
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
    }
    
    //MARK: - Setup constraints
    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom) // Убедитесь, что коллекция ограничена safeArea
        }
    }
    
    //MARK: - Setup collectionView
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //MARK: - Load favorite items
    private func loadFavoriteItems() {
        // Получить все избранные элементы из FavoritesManager
        let allItems = FavoritesManager.shared.getFavoriteItems()
        
        favoriteFoodItems = allItems.filter { $0.type == .food }
        favoriteRestaurantItems = allItems.filter { $0.type == .restaurant }
        
        // Выводим количество элементов для отладки
        print("Favorite Food Items: \(favoriteFoodItems.count)")
        print("Favorite Restaurant Items: \(favoriteRestaurantItems.count)")
        
        collectionView.reloadData()
    }
    
    //MARK: - Segmented Control action
    @objc private func segmentedControlChanged() {
        collectionView.reloadData()
    }
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, FavoriteFoodCellDelegate, FavoriteRestaurantCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // "Food" selected
            return favoriteFoodItems.count
        case 1: // "Restaurants" selected
            return favoriteRestaurantItems.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 0: // "Food" selected
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteFoodCell.reusableId, for: indexPath) as! FavoriteFoodCell
            cell.delegate = self // Устанавливаем делегат
            let favoriteItem = favoriteFoodItems[indexPath.row]
            cell.configure(with: favoriteItem)
            return cell
        case 1: // "Restaurants" selected
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteRestaurantCell.reusableId, for: indexPath) as! FavoriteRestaurantCell
            cell.delegate = self // Устанавливаем делегат
            let favoriteItem = favoriteRestaurantItems[indexPath.row]
            cell.configure(with: favoriteItem)
            return cell
        default:
            fatalError("Invalid segment index")
        }
    }
    
    func didTapLikeButton(on cell: FavoriteFoodCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        let favoriteItem = favoriteFoodItems[indexPath.row]
        favoriteFoodItems.remove(at: indexPath.row)
        FavoritesManager.shared.removeFromFavorites(item: favoriteItem)
        collectionView.deleteItems(at: [indexPath])
    }
    
    func didTapLikeButton(on cell: FavoriteRestaurantCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        let favoriteItem = favoriteRestaurantItems[indexPath.row]
        favoriteRestaurantItems.remove(at: indexPath.row)
        FavoritesManager.shared.removeFromFavorites(item: favoriteItem)
        collectionView.deleteItems(at: [indexPath])
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    // Настроить размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 250)
    }
    
    // Настроить отступы между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
