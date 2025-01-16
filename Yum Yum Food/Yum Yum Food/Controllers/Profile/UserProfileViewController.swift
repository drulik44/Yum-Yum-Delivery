//
//  UserProfileViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.12.2024.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SnapKit
import SkyFloatingLabelTextField

class UserProfileViewController: UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        
        setupUI()
        setupConstraints()
        fetchUserData()
        navigationController?.setupCustomBackButton(for: self)

    }
    
    
    
    private let emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.configureBorderTextField(
            placeholder: "   Your email".localized(),
            tintColor: AppColors.backgroundCell,
            textColor: AppColors.textColorMain,
            borderColor: AppColors.gray,
            selectedBorderColor: AppColors.main,
            cornerRadius: 15.0
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.configureBorderTextField(
            placeholder: "   Your name".localized(),
            tintColor: AppColors.backgroundCell,
            textColor: AppColors.textColorMain,
            borderColor: AppColors.gray,
            selectedBorderColor: AppColors.main,
            cornerRadius: 15.0
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let surnameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.configureBorderTextField(
            placeholder: "   Your surname".localized(),
            tintColor: AppColors.backgroundCell,
            textColor: AppColors.textColorMain,
            borderColor: AppColors.gray,
            selectedBorderColor: AppColors.main,
            cornerRadius: 15.0
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var saveButton: UIButton = {
            let button = UIButton()
            button.setTitle("Save".localized(), for: .normal)
        button.backgroundColor = AppColors.main
        button.setTitleColor(AppColors.backgroundCell, for: .normal)
            button.titleLabel?.font = .Rubick.regular.size(of: 20)
            button.layer.cornerRadius = 25
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 30)
        label.textAlignment = .center
        label.text = "Edit Profile".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = AppColors.subTitleColor
        label.font = .Rubick.bold.size(of:16)
        return label
    }()
    
    lazy var  nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name".localized()
        label.textColor = AppColors.subTitleColor
        label.font = .Rubick.bold.size(of:16)
        return label
    }()
    
    lazy var  surnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Surname".localized()
        label.textColor = AppColors.subTitleColor
        label.font = .Rubick.bold.size(of:16)
        return label
    }()
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(surnameLabel)
        view.addSubview(emailLabel)
        
        
        view.addSubview(nameTextField)
        
       
        view.addSubview(surnameTextField)
        
       
        emailTextField.keyboardType = .emailAddress
        view.addSubview(emailTextField)
        
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        surnameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameLabel.snp.bottom).offset(5)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(40)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(50)
        }
    }
    
    private func fetchUserData() {
        if let user = Auth.auth().currentUser {
            let userRef = Firestore.firestore().collection("users").document(user.uid)
            userRef.getDocument { document, error in
                if let error = error {
                    print("Ошибка получения данных пользователя: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document, document.exists, let data = document.data() else { return }
                self.nameTextField.text = data["name"] as? String
                self.surnameTextField.text = data["surname"] as? String
                self.emailTextField.text = data["email"] as? String
            }
        }
    }
    
    @objc private func saveButtonTapped() {
        guard let user = Auth.auth().currentUser else { return }
        
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        let userRef = Firestore.firestore().collection("users").document(user.uid)
        userRef.updateData([
            "name": name,
            "surname": surname,
            "email": email
        ]) { error in
            if let error = error {
                print("Ошибка обновления данных пользователя: \(error.localizedDescription)")
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("UserProfileUpdated"), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

