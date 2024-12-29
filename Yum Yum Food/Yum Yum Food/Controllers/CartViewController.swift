//
//  CartViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 26.12.2024.
//

import UIKit
import SnapKit

class CartViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupCustomBackButton(for: self)
        navigationItem.title = "You order"

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of:24)
        label.text = "Order items"
        return label
    }()
    
    
    
    
   //MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = AppColors.background
        
        view.addSubview(titleLabel)

    }
    
    //MARK: - Setup constraints
   private func setupConstraints() {
       titleLabel.snp.makeConstraints { make in
           make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
           make.left.equalToSuperview().offset(20)
       }
    }

}
