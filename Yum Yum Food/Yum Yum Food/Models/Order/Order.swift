//
//  Order.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 31.12.2024.
//

import Foundation

struct Order {
    let items: [CartItem]
    let name: String
    let imageUrl: String
    let totalPrice: Double
    let date: Date

    init(items: [CartItem]) {
        self.items = items
        self.totalPrice = items.reduce(0) { $0 + $1.finalPrice }
        self.date = Date()

        if let firstItem = items.first {
            self.name = firstItem.menuItem.name
            self.imageUrl = firstItem.menuItem.imageUrl
        } else {
            self.name = "Empty Order"
            self.imageUrl = ""
        }
    }
}
