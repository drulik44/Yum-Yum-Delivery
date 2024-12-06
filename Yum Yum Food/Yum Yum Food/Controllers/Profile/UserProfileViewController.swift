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

class UserProfileViewController: UIViewController {
    
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()
    private let emailTextField = UITextField()
    private let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupConstraints()
        fetchUserData()
        navigationController?.setupCustomBackButton(for: self)

    }
    
    private func setupUI() {
        nameTextField.placeholder = "Имя"
        nameTextField.borderStyle = .roundedRect
        view.addSubview(nameTextField)
        
        surnameTextField.placeholder = "Фамилия"
        surnameTextField.borderStyle = .roundedRect
        view.addSubview(surnameTextField)
        
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.keyboardType = .emailAddress
        view.addSubview(emailTextField)
        
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(20)
            make.left.right.equalTo(nameTextField)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
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

