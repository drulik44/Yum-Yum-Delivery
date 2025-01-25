//
//  HomeModel.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.01.2025.
//

import Foundation
import FirebaseFirestore
class HomeModel {
    private let db = Firestore.firestore()
    
    func fetchFastestDelivery(completion: @escaping ([FoodItem]) -> Void) {
        db.collection("fastest_delivery").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
            } else {
                let items = querySnapshot?.documents.compactMap { document -> FoodItem? in
                    let data = document.data()
                    return FoodItem(
                        name: data["name"] as? String ?? "",
                        rating: data["rating"] as? Double ?? 0.0,
                        deliveryTime: data["deliveryTime"] as? String ?? "",
                        imageUrl: data["imageUrl"] as? String ?? "",
                        deliveryPrice: data["deliveryPrice"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        nameRestaurant: data["nameRestaurants"] as? String ?? "",
                        price: data["price"] as? String ?? ""
                    )
                } ?? []
                completion(items)
            }
        }
    }
    
    func fetchPopularItems(completion: @escaping ([FoodItem]) -> Void) {
        db.collection("popular_items").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
            } else {
                let items = querySnapshot?.documents.compactMap { document -> FoodItem? in
                    let data = document.data()
                    return FoodItem(
                        name: data["name"] as? String ?? "",
                        rating: data["rating"] as? Double ?? 0.0,
                        deliveryTime: data["deliveryTime"] as? String ?? "",
                        imageUrl: data["imageUrl"] as? String ?? "",
                        deliveryPrice: data["deliveryPrice"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        nameRestaurant: data["nameRestaurants"] as? String ?? "",
                        price: data["price"] as? String ?? ""
                    )
                } ?? []
                completion(items)
            }
        }
    }
}
