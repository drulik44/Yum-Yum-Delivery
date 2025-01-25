//
//  FoodDetailModel.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.01.2025.
//

import Foundation

class FoodDetailsModel {
    func addToFavorites(item: MenuItem) {
        let favoriteItem = FavoriteItem(
            id: item.id,
            name: item.name,
            description: item.description,
            imageUrl: item.imageUrl,
            price: item.price,
            rating: 0,
            deliveryTime: "",
            deliveryPrice: "",
            type: .food
        )
        FavoritesManager.shared.addToFavorites(item: favoriteItem)
    }
    
    func removeFromFavorites(item: MenuItem) {
        let favoriteItem = FavoriteItem(
            id: item.id,
            name: item.name,
            description: item.description,
            imageUrl: item.imageUrl,
            price: item.price,
            rating: 0,
            deliveryTime: "",
            deliveryPrice: "",
            type: .food
        )
        FavoritesManager.shared.removeFromFavorites(item: favoriteItem)
    }
    
    func addToCart(item: MenuItem, quantity: Int, includePackage: Bool) {
        let cleanedPriceString = item.price
            .replacingOccurrences(of: ",", with: ".")
            .trimmingCharacters(in: .whitespaces)
        
        let price = Double(cleanedPriceString) ?? 0.0
        var finalPrice = Double(quantity) * price
        
        if includePackage {
            finalPrice += 20.00
        }
        
        CartManager.shared.addToCart(item: item, quantity: quantity, finalPrice: finalPrice)
    }
}
