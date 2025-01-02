//
//  OrderViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.12.2024.
//

import UIKit

class OrderViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    private var orders: [Order] = []

    private let collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           layout.minimumLineSpacing = 16
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.showsVerticalScrollIndicator = false
           collectionView.backgroundColor = .clear
           collectionView.register(OrderCell.self, forCellWithReuseIdentifier: OrderCell.reusableId)
           return collectionView
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        loadOrders()
        
    }
    
        //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
    }
    
    
    private func loadOrders() {
        // Загружаем все заказы из OrderManager
        orders = OrdersManager.shared.getOrders()
        print("Loaded orders: \(orders)")
        collectionView.reloadData()
    }

    
    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return orders.count
      }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Loading cell for indexPath: \(indexPath)")
        
        // Декьючим ячейку
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCell.reusableId, for: indexPath) as? OrderCell else {
            print("Failed to dequeue cell")
            return UICollectionViewCell()
        }
        
        // Получаем заказ
        let order = orders[indexPath.row]
        
        // Преобразуем totalPrice в строку
        let priceString = String(format: "%.2f", order.totalPrice)  // Форматируем число с двумя знаками после запятой
        
        // Создаем MenuItem с необходимыми параметрами
        let menuItem = MenuItem(id: UUID().uuidString,  // Генерируем уникальный id
                                name: order.name,
                                price: priceString,  // Передаем цену как строку
                                imageUrl: order.imageUrl,  // Используем URL изображения
                                description: "")  // Описание, если нужно, можно оставить пустым
        
        // Создаем CartItem
        let cartItem = CartItem(menuItem: menuItem, quantity: 1, finalPrice: order.totalPrice)
        
        // Конфигурируем ячейку
        cell.configure(with: cartItem)
        
        return cell
    }

    


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 120)  // Размеры ячеек
    }
    
}
