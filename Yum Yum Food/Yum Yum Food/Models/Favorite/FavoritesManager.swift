//
//  FavoritesManager.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 21.12.2024.
//

import Foundation



class FavoritesManager {
    static let shared = FavoritesManager()
    private init() {}
    
    var favoriteItems: [FavoriteItem] = []
    
    func addToFavorites(item: FavoriteItem) {
        favoriteItems.append(item)
    }
    
    func removeFromFavorites(item: FavoriteItem) {
        if let index = favoriteItems.firstIndex(where: { $0.id == item.id }) {
            favoriteItems.remove(at: index)
        }
    }
    
    func getFavoriteItems() -> [FavoriteItem] {
           return favoriteItems
       }
}
