import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if isLoggedIn() {
            showMainTabBar()
        } else {
            showWelcomeScreen()
        }
    }

    func isLoggedIn() -> Bool {
        // Логика проверки, залогинен ли пользователь
        return true
    }

    func showWelcomeScreen() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.coordinator = self
        navigationController.pushViewController(welcomeVC, animated: true)
    }

    func showLoginScreen() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }

    func showMainTabBar() {
        let tabBarController = MainTabBarController()
        
        // Создание и настройка координаторов для вкладок
        let homeNavController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavController)
        homeCoordinator.start()
        homeNavController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let restaurantsNavController = UINavigationController()
        let restaurantsCoordinator = RestaurantsCoordinator(navigationController: restaurantsNavController)
        restaurantsCoordinator.start()
        restaurantsNavController.tabBarItem = UITabBarItem(title: "Restaurants", image: UIImage(systemName: "fork.knife"), tag: 1)
        
        let searchNavController = UINavigationController()
        let searchCoordinator = SearchCoordinator(navigationController: searchNavController)
        searchCoordinator.start()
        searchNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        let favoriteNavController = UINavigationController()
        let favoriteCoordinator = FavoriteCoordinator(navigationController: favoriteNavController)
        favoriteCoordinator.start()
        favoriteNavController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 3)
        
        let profileNavController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavController)
        profileCoordinator.start()
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 4)
        
        tabBarController.viewControllers = [homeNavController, restaurantsNavController, searchNavController, favoriteNavController, profileNavController]
        navigationController.setViewControllers([tabBarController], animated: false)
        
        // Добавление дочерних координаторов к массиву childCoordinators
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(restaurantsCoordinator)
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(favoriteCoordinator)
        childCoordinators.append(profileCoordinator)
    }
}

