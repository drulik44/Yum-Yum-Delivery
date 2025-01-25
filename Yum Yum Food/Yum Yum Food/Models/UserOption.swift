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
        UserOption(title: "My Profile".localized(), icon: UIImage(named: "profile vc")),
        UserOption(title: "My Orders".localized(), icon: UIImage(named: "order")),
        UserOption(title: "Delivery Address".localized(), icon: UIImage(named: "delivery address")),
        UserOption(title: "Payments Methods".localized(), icon: UIImage(named: "wallet")),
        UserOption(title: "Contact Us".localized(), icon: UIImage(named: "contact")),
        UserOption(title: "Settings".localized(), icon: UIImage(named: "settings")),
        UserOption(title: "Help & FAQ".localized(), icon: UIImage(systemName: "questionmark.circle.fill"))
    ]
}
