//
//  CartViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 26.12.2024.
//

import UIKit
import SnapKit
protocol ShoppingCartCellDelegate: AnyObject {
    func didUpdateQuantity(for item: CartItem, quantity: Int)
    func didRemoveItem(_ item: CartItem)

}

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ShoppingCartCellDelegate {

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
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")

        return collectionView
    }()
    
    private let checkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(AppColors.backgroundCell, for: .normal)
        button.titleLabel?.font = .Rubick.bold.size(of: 24)
        button.backgroundColor = AppColors.main
        button.layer.cornerRadius = 24
        return button
    }()
    
   
    
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = AppColors.main
        view.hidesWhenStopped = true
        return view
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.isHidden = true
        return view
    }()

    
    private var cartItems: [CartItem] = []
    private var totalPrice: Double = 0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupCustomBackButton(for: self)
        navigationItem.title = "Your order"
    }
    
    
    
    func updateTotalPrice() {
    
           totalPrice = cartItems.reduce(0) { $0 + $1.finalPrice } // Пересчитываем общую стоимость
           updateFooter() // Обновляем отображение в футере
       }

    private func updateFooter() { // Выносим обновление футера в отдельный метод
          let footerIndexPath = IndexPath(item: 0, section: 0)
          if let footer = shoppingCartView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: footerIndexPath) as? FooterView {
              let numberFormatter = NumberFormatter()
              numberFormatter.numberStyle = .currency
              numberFormatter.currencySymbol = "₴"
              numberFormatter.locale = Locale(identifier: "uk_UA") // или текущая локаль пользователя
              footer.totalPriceLabel.text = numberFormatter.string(from: NSNumber(value: totalPrice)) ?? "0₴"
          }
      }



    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        cartItems = CartManager.shared.getCartItems()
        shoppingCartView.dataSource = self
        shoppingCartView.delegate = self
        updateTotalPrice()
    }

    private func setupUI() {
        view.backgroundColor = AppColors.background
        view.addSubview(titleLabel)
        view.addSubview(shoppingCartView)
        view.addSubview(indicatorView)
        view.addSubview(overlayView)
        view.addSubview(checkoutButton)
        checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.left.equalToSuperview().offset(20)
        }

        shoppingCartView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            //make.bottom.equalToSuperview().offset(70)
            make.bottom.equalTo(checkoutButton.snp.top).offset(-20) // Отступ от кнопки

        }
       
        indicatorView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        checkoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20) // Отступ от нижнего края

            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
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
        cell.delegate = self
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 120)  // Размеры ячеек
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50) // Размер футера
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath) as! FooterView
            footer.totalPriceLabel.text = " \(cartItems.reduce(0) { $0 + $1.finalPrice })₴"
            return footer
        }
        return UICollectionReusableView()
    }

    
    //MARK: - SETUP DELEGATE
    
    //MARK: - FUNC UPDATE CELL
    func didUpdateQuantity(for item: CartItem, quantity: Int) {
        overlayView.isHidden = false
        view.bringSubviewToFront(indicatorView)
        indicatorView.startAnimating()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in // Имитация задержки (например, сетевой запрос)
            guard let self = self else { return }
            
            
            if let index = cartItems.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
                // Фильтрация и преобразование строки в Double прямо в коде
                let priceString = cartItems[index].menuItem.price
                let filteredString = priceString
                    .replacingOccurrences(of: ",", with: ".") // Заменяем запятую на точку
                    .trimmingCharacters(in: .whitespaces)
                
                if let price = Double(filteredString) {
                    cartItems[index].quantity = quantity
                    cartItems[index].finalPrice = price * Double(quantity) // Обновляем итоговую цену
                }
            }
            
            updateTotalPrice()
            
            if let index = cartItems.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
                let indexPath = IndexPath(item: index, section: 0)
                shoppingCartView.reloadItems(at: [indexPath])
            }
            self.overlayView.isHidden = true
            self.indicatorView.stopAnimating()
            
        }
    }
    
    // MARK: - Func remove
    func didRemoveItem(_ item: CartItem) {
            if let index = cartItems.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
                cartItems.remove(at: index) // Удаляем элемент из массива
                shoppingCartView.deleteItems(at: [IndexPath(item: index, section: 0)]) // Удаляем ячейку из коллекции
                updateTotalPrice() // Обновляем общую стоимость
            }
        }
    
    //MARK: - FUNC Chackout button tapped
    
   
    
    @objc private func checkoutButtonTapped() {
        updateTotalPrice()
        guard !cartItems.isEmpty else {
            print("Корзина пуста!")
            return
        }

        let order = Order(items: cartItems)

        OrdersManager.shared.addOrder(order)

        CartManager.shared.clearCart()
        cartItems.removeAll()
        print("After removal, cartItems: \(cartItems)")

        let isNotificationsEnabled = UserDefaults.standard.bool(forKey: "pushNotificationsEnabled")
        if isNotificationsEnabled {
            scheduleLocalNotification()
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.shoppingCartView.reloadData()
            self.shoppingCartView.layoutIfNeeded()
            self.navigationController?.popViewController(animated: true)
        }
    }

    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Order Accepted"
        content.body = "A courier will contact you soon, please wait)"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при создании уведомления: \(error.localizedDescription)")
            }
        }
    }

    
}
