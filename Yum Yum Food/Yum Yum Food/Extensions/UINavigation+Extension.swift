//
//  UINavigation+Extension.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 05.12.2024.
//

import UIKit

extension UINavigationController: @retroactive UINavigationControllerDelegate, @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        interactivePopGestureRecognizer?.delegate = self
    }

    func setupCustomBackButton(for viewController: UIViewController) {
        let backButton = UIButton(type: .system)
        backButton.backgroundColor = UIColor.darkGray.withAlphaComponent(0.8)
        backButton.layer.cornerRadius = 20 // Круглая кнопка диаметром 40
        backButton.setImage(UIImage(named: "back button icon"), for: .normal)
        backButton.tintColor = .white
        if let originalImage = UIImage(named: "back button icon") {
            let resizedImage = originalImage.resized(to: CGSize(width: 25, height: 25))
            backButton.setImage(resizedImage, for: .normal)
        }
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        viewController.navigationItem.leftBarButtonItem = backBarButtonItem

        // Устанавливаем констрейнты для backButton
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
             // Устанавливаем края равными супервью (контейнеру)
        }
    }

    @objc private func backButtonTapped() {
        popViewController(animated: true)
    }
}
