//
//  NoficationViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 09.01.2025.
//

import UIKit
import SnapKit

class NoficationViewController: UIViewController {
    
    weak var coordinator: SettingsCoordinator?

    override func loadView() {
        super.loadView()
        view.backgroundColor = AppColors.background
        setupUI()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setupCustomBackButton(for: self)

    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Current order information"
        return label
    }()
    
    private let pancholderlabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.grayForTextCell
        label.font = .Rubick.regular.size(of: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "The most important events and messages from the courier and support service related to your current order"
        return label
    }()
    
    
    private let pushImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit // Важно для правильного масштабирования

        if let originalImage = UIImage(named: "Smartphone Icon") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            imageView.image = resizedImage // Правильно устанавливаем изображение
        } else {
            print("Error: Smartphone Icon not found!")
            imageView.image = UIImage(systemName: "xmark.octagon.fill") // Или другое placeholder изображение
            imageView.tintColor = .red
        }

        return imageView
    }()
    
    private let pushLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.grayForTextCell
        label.font = .Rubick.regular.size(of: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Push notifications"
        return label
    }()
    
    private let pushSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.isOn = true
        switchView.onTintColor = AppColors.main
        return switchView
    }()
    
    //MARK: - Setup UI
    
    private func setupUI() {
        navigationItem.title = "Nofication"

        view.addSubview(titleLabel)
        view.addSubview(pancholderlabel)
        view.addSubview(pushImageView)
        view.addSubview(pushLabel)
        view.addSubview(pushSwitch)
        
        
    }

    
    
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(20)
            
        }
        
        pancholderlabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        pushImageView.snp.makeConstraints { make in
            make.top.equalTo(pancholderlabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        pushLabel.snp.makeConstraints { make in
            make.top.equalTo(pushImageView)
            make.left.equalTo(pushImageView.snp.right).offset(10)
        }
        
        pushSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(pushLabel)
            make.right.equalToSuperview().offset(-20)
        }
    }
}
