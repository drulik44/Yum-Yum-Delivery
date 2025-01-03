//
//  File.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    
    func showFastestDelivery() {
        let vc = FastestDeliveryViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showPopularDelivery() {
        let vc = PopularDeliveryViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

