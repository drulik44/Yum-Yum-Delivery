//
//  RestaurantsModel.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.01.2025.
//

import Foundation
import FirebaseFirestore


class RestaurantsModel {
    private let db = Firestore.firestore()
    
    func fetchRestaurants(completion: @escaping ([Restaurant]) -> Void) {
        db.collection("restaurants").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error)")
                completion([])
            } else {
                let restaurants = querySnapshot?.documents.compactMap { document -> Restaurant? in
                    let data = document.data()
                    return Restaurant(
                        id: document.documentID,
                        name: data["name"] as? String ?? "",
                        rating: data["rating"] as? Double ?? 0.0,
                        deliveryTime: data["deliveryTime"] as? String ?? "",
                        imageUrl: data["imageUrl"] as? String ?? "",
                        deliveryPrice: data["deliveryPrice"] as? String ?? "",
                        description: data["description"] as? String ?? ""
                    )
                } ?? []
                completion(restaurants)
            }
        }
    }
}
