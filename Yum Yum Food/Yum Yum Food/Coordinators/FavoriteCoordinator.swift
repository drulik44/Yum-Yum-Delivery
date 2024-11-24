//
//  FavoriteCoordinator.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit

class FavoriteCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = FavoriteViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

}
