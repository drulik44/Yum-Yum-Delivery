//
//  OrdersManager.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 31.12.2024.
//

class OrdersManager {
    static let shared = OrdersManager()
    private init() {}
    
    var orders: [Order] = []

    func addOrder(_ order: Order) {
        orders.append(order)
    }
    
    func getOrders() -> [Order] {
        return orders
    }

    func clearOrders() {
        orders.removeAll()
    }
}

