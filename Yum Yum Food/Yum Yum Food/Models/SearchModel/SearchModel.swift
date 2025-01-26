//
//  SearchModel.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 25.01.2025.
//

import Foundation
import FirebaseFirestore


class SearchModel {
    private let db = Firestore.firestore()
    
    func searchFoodItems(query: String, completion: @escaping ([FoodItem]?, Error?) -> Void) {
        db.collection("fastest_delivery")
            .whereField("name", isGreaterThanOrEqualTo: query)
            .whereField("name", isLessThan: query + "\u{f8ff}")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let documents = snapshot?.documents else {
                    completion([], nil)
                    return
                }
                let results = documents.map { doc -> FoodItem in
                    let data = doc.data()
                    return FoodItem(
                        name: data["name"] as? String ?? "",
                        rating: data["rating"] as? Double ?? 0.0,
                        deliveryTime: data["deliveryTime"] as? String ?? "",
                        imageUrl: data["imageUrl"] as? String ?? "",
                        deliveryPrice: data["deliveryPrice"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        nameRestaurant: "",
                        price: ""
                    )
                }
                completion(results, nil)
            }
    }
}
