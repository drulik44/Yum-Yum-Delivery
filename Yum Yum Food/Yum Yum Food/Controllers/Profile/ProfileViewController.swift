//
//  ProfileViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import SnapKit

class ProfileViewController: UIViewController {
    weak var coordinator: ProfileCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.background
        setupUI()
        setupConstraints()
        fetchUserData()
    }
    
    //MARK: - USER INFO
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size( of: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.subTitleColor
        label.font = .Rubick.regular.size( of: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Setup user info
    private func fetchUserData() {
        if let user = Auth.auth().currentUser {
            self.nameLabel.text = user.displayName ?? "No name"
            self.emailLabel.text = user.email
        }
    }
    
    //MARK: - Setup UI
    func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        
    }
    
    
    
    
    //MARK: - SETUP CONSTRAINTS
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
}
