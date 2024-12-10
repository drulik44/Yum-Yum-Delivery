//
//  FoodItem.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 08.12.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseDatabase


struct FoodItem {
    let name: String
    let rating: Double
    let deliveryTime: String
    let imageUrl: String
    let deliveryPrice: Double
    let description: String
    
}

