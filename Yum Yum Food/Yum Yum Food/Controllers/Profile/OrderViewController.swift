//
//  OrderViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.12.2024.
//

import UIKit

class OrderViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)
    }
    
}
