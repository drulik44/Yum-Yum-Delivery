//
//  PopularDeliveryViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.01.2025.
//

import UIKit

class PopularDeliveryViewController: UIViewController {
    weak var coordinator: HomeCoordinator?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupCustomBackButton(for: self)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    

    //MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = AppColors.background
    }
}
