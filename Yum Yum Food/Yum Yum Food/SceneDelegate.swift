//
//  SceneDelegate.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import UserNotifications


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        NotificationCenter.default.addObserver(self, selector: #selector(handleReloadRootViewController), name: .init("ReloadRootViewController"), object: nil)
        
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = AppColors.textColorMain
        appearance.titleTextAttributes = [
            .font: UIFont.Rubick.bold.size(of: 17),
            .foregroundColor: AppColors.textColorMain
        ]

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigationController = UINavigationController()
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        mainCoordinator?.start()

        window?.makeKeyAndVisible()
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see application:didDiscardSceneSessions instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    func reloadRootViewController() {
        guard let windowScene = window?.windowScene else { return }

        // Создаём новый навигационный контроллер и координатор
        let navigationController = UINavigationController()
        mainCoordinator = MainCoordinator(navigationController: navigationController)

        // Устанавливаем обновлённый rootViewController
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        mainCoordinator?.start()

        // Делаем окно видимым
        window?.makeKeyAndVisible()
    }


    @objc private func handleReloadRootViewController() {
        reloadRootViewController()
    }
}
