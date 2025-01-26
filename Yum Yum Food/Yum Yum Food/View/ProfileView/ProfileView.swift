//
//  ProfileView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 25.01.2025.
//

import Foundation
import UIKit
import SnapKit

class ProfileView: UIView {
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = AppColors.main.cgColor
        imageView.image = UIImage(named: "Profile imageView")
        imageView.tintColor = AppColors.gray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 25)
        label.textAlignment = .center
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.gray
        label.font = .Rubick.regular.size(of: 18)
        label.textAlignment = .center
        return label
    }()
    
    let logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.setTitle("Log Out".localized(), for: .normal)
        button.setTitleColor(AppColors.main, for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 18)
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.borderWidth = 1
        button.layer.borderColor = AppColors.main.cgColor
        
        if let originalImage = UIImage(named: "Log out") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
            button.setImage(tintedImage, for: .normal)
        }
        
        button.tintColor = AppColors.main
        return button
    }()
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.showsVerticalScrollIndicator = false
        tv.scrollsToTop = false
        tv.separatorColor = UIColor.clear
        tv.separatorStyle = .none
        tv.backgroundColor = AppColors.background
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(emailLabel)
        addSubview(tableView)
        addSubview(logOutButton)
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
            make.top.equalToSuperview().offset(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-75)
        }
        
        logOutButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
}
