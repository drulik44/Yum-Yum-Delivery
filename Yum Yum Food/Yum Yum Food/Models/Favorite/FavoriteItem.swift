//
//  FavoriteItem.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 21.12.2024.
//

import Foundation

struct FavoriteItem {
    let id: String
    let name: String
    let description: String
    let imageUrl: String
    let price: String
    let rating: Double
    let deliveryTime: String
    let deliveryPrice: String
    let type: FavoriteType
}

enum FavoriteType {
    case food
    case restaurant
}
