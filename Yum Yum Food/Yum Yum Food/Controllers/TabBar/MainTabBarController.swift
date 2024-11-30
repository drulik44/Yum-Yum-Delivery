//
//  MainTabBarController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        // Создание навигационного контроллера для Home
        let homeNavController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavController)
        homeCoordinator.start()
        homeNavController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)

        // Создание навигационного контроллера для
        let restaurantsNavController = UINavigationController()
        let restaurantsCoordinator = RestaurantsCoordinator(navigationController: restaurantsNavController)
        restaurantsCoordinator.start()
        restaurantsNavController.tabBarItem = UITabBarItem(title: "Restaurants", image: UIImage(named: "Restaurants"), tag: 1)
        
        let searchNavController = UINavigationController()
        let searcCoordinator = SearchCoordinator(navigationController: searchNavController)
        searcCoordinator.start()
        searchNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "Search"), tag: 2)
        
        
        let favoriteNavController = UINavigationController()
        let favoriteCoordinator = FavoriteCoordinator(navigationController: favoriteNavController)
        favoriteCoordinator.start()
        favoriteNavController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "Favorite"), tag: 3)
        
        let profileNavController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavController)
        profileCoordinator.start()
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Profile"), tag: 4)
        
       

        // Настройка вкладок таббар-контроллера
        let tabBarList = [homeNavController, restaurantsNavController, searchNavController, favoriteNavController, profileNavController]
        viewControllers = tabBarList
    }
}
