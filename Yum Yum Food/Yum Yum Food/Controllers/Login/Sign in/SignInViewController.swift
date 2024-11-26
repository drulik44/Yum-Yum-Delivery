//
//  SignInViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 26.11.2024.
//

import UIKit

class SignInViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }
    

    func setupUI() {
        // Скрываем кнопку "назад"
        navigationItem.hidesBackButton = true
        // Ваш код для настройки UI
    }

}
