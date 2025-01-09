import UIKit
import FirebaseAuth

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let authService = AuthService()
    

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
        return Auth.auth().currentUser != nil
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

    func showsignInScreen() {
        let signUpVC = SignInViewController()
        signUpVC.coordinator = self
        navigationController.pushViewController(signUpVC, animated: true)
    }

    func showMainTabBar() {
        let tabBarController = MainTabBarController()

        let homeNavController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavController)
        homeCoordinator.start()
        homeNavController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)

        let restaurantsNavController = UINavigationController()
        let restaurantsCoordinator = RestaurantsCoordinator(navigationController: restaurantsNavController)
        restaurantsCoordinator.start()
        restaurantsNavController.tabBarItem = UITabBarItem(title: "Restaurants", image: UIImage(named: "Restaurants"), tag: 1)

        let searchNavController = UINavigationController()
        let searchCoordinator = SearchCoordinator(navigationController: searchNavController)
        searchCoordinator.start()
        searchNavController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "Search"), tag: 2)

        let favoriteNavController = UINavigationController()
        let favoriteCoordinator = FavoriteCoordinator(navigationController: favoriteNavController)
        favoriteCoordinator.start()
        favoriteNavController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "Favorite"), tag: 3)

        let profileNavController = UINavigationController()
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavController)
        profileCoordinator.parentCoordinator = self

        profileCoordinator.start()
        profileNavController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Profile"), tag: 4)

        tabBarController.viewControllers = [homeNavController, restaurantsNavController, searchNavController, favoriteNavController, profileNavController]
        navigationController.setViewControllers([tabBarController], animated: false)

        childCoordinators.append(homeCoordinator)
        childCoordinators.append(restaurantsCoordinator)
        childCoordinators.append(searchCoordinator)
        childCoordinators.append(favoriteCoordinator)
        childCoordinators.append(profileCoordinator)
        CartManager.shared.coordinator = self

    }
    
    func showCartScreen() {
        let cartVC = CartViewController() // Предположим, у вас есть этот контроллер
        cartVC.coordinator = self
        navigationController.pushViewController(cartVC, animated: true)
    }

}

