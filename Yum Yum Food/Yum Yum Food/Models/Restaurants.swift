//
//  Restaurants.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 11.12.2024.
//

import Foundation
import FirebaseFirestore

struct Restaurant {
   
    
    var id: String
    let name: String
    let rating: Double
    let deliveryTime: String
    let imageUrl: String
    let deliveryPrice: String
    let description: String
   
}
