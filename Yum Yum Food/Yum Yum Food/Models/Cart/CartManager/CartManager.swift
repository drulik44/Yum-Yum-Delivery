//
//  CartManager.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 27.12.2024.
//

import UIKit

class CartManager {
    
    private var items: [CartItem] = []
    
    static let shared = CartManager()
    private var bannerView: CartBannerView?
    weak var coordinator: MainCoordinator?
    
    // MARK: - Cart Management
    
    func addToCart(item: MenuItem, quantity: Int, finalPrice: Double) {
        let cartItem = CartItem(menuItem: item, quantity: quantity, finalPrice: finalPrice)
        items.append(cartItem)
    }
    
    func updateCartItem(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.menuItem.id == item.menuItem.id }) {
            items[index] = item
        }
    }
    
    func getCartItems() -> [CartItem] {
        return items
    }
    
    func removeFromCart(_ item: CartItem) {
        items.removeAll { $0.menuItem.id == item.menuItem.id }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func updateQuantity(for item: CartItem, quantity: Int) -> CartItem? {
        var updatedItem = item
        updatedItem.quantity = quantity
        
        let priceString = updatedItem.menuItem.price
            .replacingOccurrences(of: ",", with: ".")
            .trimmingCharacters(in: .whitespaces)
        
        if let price = Double(priceString) {
            updatedItem.finalPrice = price * Double(quantity)
        }
        
        updateCartItem(updatedItem)
        return updatedItem
    }
    
    func createOrder(from cartItems: [CartItem]) -> Order {
        return Order(items: cartItems)
    }
    
    func addOrder(_ order: Order) {
        OrdersManager.shared.addOrder(order)
    }
    
    // MARK: - Banner Management
    
    func showCartBanner() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        if bannerView == nil {
            bannerView = CartBannerView()
            bannerView?.onTap = { [weak self] in
                self?.coordinator?.showCartScreen()
                self?.hideCartBanner()
            }
            window.addSubview(bannerView!)
            bannerView?.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                bannerView!.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 16),
                bannerView!.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -16),
                bannerView!.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -70),
                bannerView!.heightAnchor.constraint(equalToConstant: 50)
            ])
        }

        bannerView?.isHidden = false
    }
    
    func hideCartBanner() {
        bannerView?.isHidden = true
    }
}
