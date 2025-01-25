//
//  RestaurantsDetailModel.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.01.2025.
//

import Foundation
import FirebaseFirestore

class RestaurantDetailModel {
    private let db = Firestore.firestore()
    
    func fetchMenuItems(for restaurantId: String, completion: @escaping ([MenuItem]) -> Void) {
        db.collection("restaurants").document(restaurantId).collection("menu_items").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching menu: \(error)")
                completion([])
            } else {
                let menuItems = querySnapshot?.documents.compactMap { document -> MenuItem? in
                    let data = document.data()
                    return MenuItem(
                        id: document.documentID,
                        name: data["name"] as? String ?? "",
                        price: data["price"] as? String ?? "",
                        imageUrl: data["imageUrl"] as? String ?? "",
                        description: data["description"] as? String ?? ""
                    )
                } ?? []
                completion(menuItems)
            }
        }
    }
}
