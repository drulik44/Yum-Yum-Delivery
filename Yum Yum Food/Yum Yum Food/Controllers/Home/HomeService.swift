//
//  HomeService.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 18.01.2025.
//

import Foundation
import FirebaseFirestore

class HomeService {
    private let db = Firestore.firestore()

    func fetchFastestDelivery(completion: @escaping ([FoodItem]) -> Void) {
        db.collection("fastest_delivery").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Ошибка при получении документов: \(error)")
                completion([])
                return
            }

            let items = querySnapshot?.documents.compactMap { document in
                let data = document.data()
                guard let name = data["name"] as? String,
                      let rating = data["rating"] as? Double,
                      let deliveryTime = data["deliveryTime"] as? String,
                      let imageUrl = data["imageUrl"] as? String,
                      let deliveryPrice = data["deliveryPrice"] as? String,
                      let description = data["description"] as? String else { return nil }
                
                return FoodItem(name: name, rating: rating, deliveryTime: deliveryTime, imageUrl: imageUrl, deliveryPrice: deliveryPrice, description: description, nameRestaurant: "", price: "")
            } ?? []

            completion(items)
        }
    }

    func fetchPopularItems(completion: @escaping ([FoodItem]) -> Void) {
        db.collection("popular_items").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Ошибка при получении документов: \(error)")
                completion([])
                return
            }

            let items = querySnapshot?.documents.compactMap { document in
                let data = document.data()
                guard let name = data["name"] as? String,
                      let rating = data["rating"] as? Double,
                      let deliveryTime = data["deliveryTime"] as? String,
                      let imageUrl = data["imageUrl"] as? String,
                      let deliveryPrice = data["deliveryPrice"] as? String,
                      let description = data["description"] as? String,
                      let nameRestaurant = data["nameRestaurants"] as? String,
                      let price = data["price"] as? String else { return nil }
                
                return FoodItem(name: name, rating: rating, deliveryTime: deliveryTime, imageUrl: imageUrl, deliveryPrice: deliveryPrice, description: description, nameRestaurant: nameRestaurant, price: price)
            } ?? []

            completion(items)
        }
    }
}
