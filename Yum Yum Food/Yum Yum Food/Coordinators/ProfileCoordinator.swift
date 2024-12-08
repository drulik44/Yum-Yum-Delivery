//
//  ProfileCoordinator.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?




    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ProfileViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func showLoginScreen() {
        parentCoordinator?.showLoginScreen()
    }

    func showWelcomeScreen() {
        parentCoordinator?.showWelcomeScreen()
    }
    
    func showUserProfile() {
        let userProfileViewController = UserProfileViewController();navigationController.pushViewController(userProfileViewController, animated: true)
    }
    
    func showOrderScreen() {
        DispatchQueue.main.async {
            let orderViewController = OrderViewController()
            self.navigationController.pushViewController(orderViewController, animated: true)
        }
    }

    
    func showPaymentsScreen() {
        let paymentViewController = PaymentsViewController();navigationController.pushViewController(paymentViewController, animated: true)
    }
    
    
    func showContactScreen() {
        let contactViewController = ContactViewController();navigationController.pushViewController(contactViewController, animated: true)
    }
    
    func showSettingsScreen() {
        let settingsViewController = SettingsViewController();navigationController.pushViewController(settingsViewController, animated: true)
    }
    
    func showHelpScreen() {
        let helpViewController = HelpFAQViewController();navigationController.pushViewController(helpViewController, animated: true)
    }
    
    func showDeliveryScreen() {
        let deliveryViewController = DeliveryAddressWithMapViewController();
        navigationController.pushViewController(deliveryViewController, animated: true)
    }
}

