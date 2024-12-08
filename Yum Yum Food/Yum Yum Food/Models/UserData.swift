//
//  UserData.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 28.11.2024.
//

import Foundation

struct  UserData : Identifiable{
    var id: String = UUID().uuidString
    var email: String
    var password: String
    var name: String?
}
