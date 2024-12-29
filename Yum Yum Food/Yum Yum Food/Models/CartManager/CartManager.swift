//
//  CartManager.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 27.12.2024.
//

import UIKit

class CartManager {
    static let shared = CartManager()
    private var bannerView: CartBannerView?
    weak var coordinator: MainCoordinator?
    
    func showCartBanner() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }

        if bannerView == nil {
                    bannerView = CartBannerView()
                    bannerView?.onTap = { [weak self] in
                        self?.coordinator?.showCartScreen()
                        self?.hideCartBanner()
                    }
                    window.addSubview(bannerView!)
                    bannerView?.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                bannerView!.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 16),
                bannerView!.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -16),
                bannerView!.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -70),
                bannerView!.heightAnchor.constraint(equalToConstant: 50)
            ])
        }

        bannerView?.isHidden = false
    }


    func hideCartBanner() {
        bannerView?.isHidden = true
    }
}

