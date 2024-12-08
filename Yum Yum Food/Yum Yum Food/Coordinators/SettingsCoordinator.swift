//
//  SettingsCoordinator.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 08.12.2024.
//

import UIKit

class SettingsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?




    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = SettingsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

   }

