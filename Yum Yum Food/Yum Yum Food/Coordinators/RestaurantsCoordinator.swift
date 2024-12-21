//
//  2.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit

class RestaurantsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = RestaurantsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
   
        func showRestaurantDetail(for restaurant: Restaurant) {
            let detailVC = RestaurantDetailViewController()
            detailVC.restaurant = restaurant
            navigationController.pushViewController(detailVC, animated: true)
        }
    
    
    
      
    
    }



