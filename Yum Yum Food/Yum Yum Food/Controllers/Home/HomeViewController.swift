//
//  HomeViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit

class HomeViewController: UIViewController {
    weak var coordinator: HomeCoordinator?
    private let customAddressView = CustomAddressView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = AppColors.background
        setupUI()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openDeliveryAddressVC))
        customAddressView.addGestureRecognizer(tapGesture)
        customAddressView.isUserInteractionEnabled = true
        
        
    }
    
    //MARK: - Banner
    
    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner 1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private func setupUI() {
        view.addSubview(customAddressView)
        view.addSubview(bannerImageView)
    }
    
    private func setupConstraints() {
        customAddressView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(70)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        bannerImageView.snp.makeConstraints { make in
            make.top.equalTo(customAddressView.snp.bottom).offset(40)
            make.height.equalTo(190)
            make.width.equalTo(350)
            make.centerX.equalToSuperview()
        }
        
    }
        @objc private func openDeliveryAddressVC() {
            let deliveryVC = DeliveryAddressWithMapViewController()
            
            deliveryVC.addressCompletion = { [weak self] address in
                self?.customAddressView.addressLabel.text = address
            }
            
            navigationController?.pushViewController(deliveryVC, animated: true)
        }
    }

