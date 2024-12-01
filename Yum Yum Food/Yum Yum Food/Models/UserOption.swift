//
//  UserOption.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 01.12.2024.
//

import UIKit

struct UserOption {
    var title: String
    var icon: UIImage?
    
    static let options: [UserOption] = [
        UserOption(title: "My Profile", icon: UIImage(named: "profile vc")),
        UserOption(title: "My Orders", icon: UIImage(named: "order")),
        UserOption(title: "Delivery Address", icon: UIImage(named: "delivery address")),
        UserOption(title: "Payments Methods", icon: UIImage(named: "wallet")),
        UserOption(title: "Contact Us", icon: UIImage(named: "contact")),
        UserOption(title: "Settings", icon: UIImage(named: "settings")),
        UserOption(title: "Help & FAQ", icon: UIImage(systemName: "questionmark.circle.fill"))
    ]
}
