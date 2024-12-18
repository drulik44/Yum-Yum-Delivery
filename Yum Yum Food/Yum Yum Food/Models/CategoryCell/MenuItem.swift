//
//  MenuItem.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 17.12.2024.
//

import Foundation
import FirebaseFirestore


struct MenuItem {
    var id: String
    var name: String
    var price: String
    var imageUrl: String
    var description: String
    
    // Инициализатор для структуры
    init(id: String, name: String, price: String, imageUrl: String, description: String) {
        self.id = id
        self.name = name
        self.price = price
        self.imageUrl = imageUrl
        self.description = description
    }
}
