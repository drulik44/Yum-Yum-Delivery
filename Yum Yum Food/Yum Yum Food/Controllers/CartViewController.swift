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


import UIKit

class CartViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    private let cartView = CartView()
    private let cartManager = CartManager.shared
    
    private var cartItems: [CartItem] = []
    private var totalPrice: Double = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupCustomBackButton(for: self)
        navigationItem.title = "Your order".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        view.addSubview(cartView)
        cartView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cartItems = cartManager.getCartItems()
        cartView.shoppingCartView.dataSource = self
        cartView.shoppingCartView.delegate = self
        updateTotalPrice()
        
        cartView.checkoutButton.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
    }
    
    private func updateTotalPrice() {
        totalPrice = cartItems.reduce(0) { $0 + $1.finalPrice }
        updateFooter()
    }
    
    private func updateFooter() {
        let footerIndexPath = IndexPath(item: 0, section: 0)
        if let footer = cartView.shoppingCartView.supplementaryView(forElementKind: UICollectionView.elementKindSectionFooter, at: footerIndexPath) as? FooterView {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencySymbol = "₴"
            numberFormatter.locale = Locale(identifier: "uk_UA")
            footer.totalPriceLabel.text = numberFormatter.string(from: NSNumber(value: totalPrice)) ?? "0₴"
        }
    }
    
    @objc private func checkoutButtonTapped() {
        updateTotalPrice()
        guard !cartItems.isEmpty else {
            print("Корзина пуста!")
            return
        }
        
        let order = cartManager.createOrder(from: cartItems)
        cartManager.addOrder(order)
        cartManager.clearCart()
        cartItems.removeAll()
        
        let isNotificationsEnabled = UserDefaults.standard.bool(forKey: "pushNotificationsEnabled")
        if isNotificationsEnabled {
            scheduleLocalNotification()
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cartView.shoppingCartView.reloadData()
            self.cartView.shoppingCartView.layoutIfNeeded()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Order Accepted".localized()
        content.body = "A courier will contact you soon, please wait)".localized()
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

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension CartViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
        return CGSize(width: collectionView.bounds.width - 10, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath) as! FooterView
            footer.totalPriceLabel.text = " \(cartItems.reduce(0) { $0 + $1.finalPrice })₴"
            return footer
        }
        return UICollectionReusableView()
    }
}

// MARK: - ShoppingCartCellDelegate
extension CartViewController: ShoppingCartCellDelegate {
    func didUpdateQuantity(for item: CartItem, quantity: Int) {
        cartView.overlayView.isHidden = false
        view.bringSubviewToFront(cartView.indicatorView)
        cartView.indicatorView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            if let updatedItem = self.cartManager.updateQuantity(for: item, quantity: quantity) {
                if let index = self.cartItems.firstIndex(where: { $0.menuItem.id == updatedItem.menuItem.id }) {
                    self.cartItems[index] = updatedItem
                    self.updateTotalPrice()
                    let indexPath = IndexPath(item: index, section: 0)
                    self.cartView.shoppingCartView.reloadItems(at: [indexPath])
                }
            }
            
            self.cartView.overlayView.isHidden = true
            self.cartView.indicatorView.stopAnimating()
        }
    }
    
    func didRemoveItem(_ item: CartItem) {
        cartManager.removeFromCart(item)
        if let index = cartItems.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
            cartItems.remove(at: index)
            cartView.shoppingCartView.deleteItems(at: [IndexPath(item: index, section: 0)])
            updateTotalPrice()
        }
    }
}
