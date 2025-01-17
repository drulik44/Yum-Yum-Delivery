//
//  LoginViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController, UITextFieldDelegate {
    weak var coordinator: MainCoordinator?
    private let service = AuthService()
    
    var name : String? {
        return nameTextField.text
    }
    var email : String? {
        return emailTextField.text
    }
    var password : String? {
        return passwordTextField.text
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordTextField.rightView = passwordToggleButton
        passwordTextField.rightViewMode = .always
        tapped()
        
        view.backgroundColor = AppColors.background
        setupAddToSuperview()
        setupConstraints()
        setupAccountSection()
        emailTextField.delegate = self
        nameTextField.delegate = self
        passwordTextField.delegate = self
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //MARK: - Label
    let singUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of:32)
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = AppColors.subTitleColor
        label.font = .Rubick.bold.size(of:16)
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = AppColors.subTitleColor
        label.font = .Rubick.bold.size(of:16)
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = AppColors.subTitleColor
        label.font = .Rubick.bold.size(of:16)
        return label
    }()
    
    let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account? "
        label.font = .Rubick.regular.size(of: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - TextField
    
    let nameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.configureBorderTextField(
            placeholder: "   Name",
            tintColor: AppColors.textColorMain,
            textColor: AppColors.textColorMain,
            borderColor: AppColors.gray,
            selectedBorderColor: AppColors.main,
            cornerRadius: 15.0
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let emailTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.configureBorderTextField(
            placeholder: "   Your email",
            tintColor: AppColors.backgroundCell,
            textColor: AppColors.textColorMain,
            borderColor: AppColors.gray,
            selectedBorderColor: AppColors.main,
            cornerRadius: 15.0
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.configureBorderTextField(
            placeholder: "   Password",
            tintColor: AppColors.textColorMain,
            textColor: AppColors.textColorMain,
            borderColor: AppColors.gray, selectedBorderColor: AppColors.main,
            isSecure: true,
            cornerRadius: 15.0
            
            
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: - Password eye
    let passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Eye"), for: .normal) // "eye.slash" для скрытия пароля
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if let originalImage = UIImage(named: "Eye") {
            let resizedImage = originalImage.resized(to: CGSize(width: 25, height: 25))
            button.setImage(resizedImage, for: .normal)
        }
        return button
    }()
    
    
    
    //MARK: - Button
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.main
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 15)
        button.setTitleColor(AppColors.main, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 15)
        button.setTitleColor(AppColors.main, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupAccountSection() {
        let containerView = UIStackView(arrangedSubviews: [accountLabel, loginButton])
        containerView.axis = .horizontal
        containerView.spacing = 0
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Роблю надпис Sing in with
    
    let signInWithLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in with"
        label.font = .Rubick.regular.size(of: 18)
        label.textColor = AppColors.subTitleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftLine: UIView = {
        let line = UIView()
        line.backgroundColor = AppColors.subTitleColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let rightLine: UIView = {
        let line = UIView()
        line.backgroundColor = AppColors.subTitleColor
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    //MARK: - Make button Google
    
    let googleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  Continue with Google", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setImage(UIImage(named: "Gicon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        if let originalImage = UIImage(named: "Gicon") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            button.setImage(resizedImage, for: .normal)
        }
        return button
    }()
    
    //MARK: - Кнопка Facebook
    
    let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" Continue with Facebook", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setImage(UIImage(named: "Facebook"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        if let originalImage = UIImage(named: "Facebook") {
            let resizedImage = originalImage.resized(to: CGSize(width: 30, height: 30))
            button.setImage(resizedImage, for: .normal)
        }
        return button
    }()
    
    
    func setupAddToSuperview() {
        view.addSubview(singUpLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(signUpButton)
        view.addSubview(signInWithLabel)
        view.addSubview(rightLine)
        view.addSubview(leftLine)
        view.addSubview(googleButton)
        view.addSubview(facebookButton)
        
        
    }
    
    
    //MARK: - Func password eye
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        
        let iconName = passwordTextField.isSecureTextEntry ? "Eye" : "Eye-closed"
        
        if let originalImage = UIImage(named: iconName) {
            let resizedImage = originalImage.resized(to: CGSize(width: 25, height: 25))
            passwordToggleButton.setImage(resizedImage, for: .normal)
        }
    }
    
    //MARK: - LAZY  allert
    lazy var alertVerification: UIAlertController = {
        let alert = UIAlertController(title: "Verification", message: "Please check your email for verification", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { (action) in
            self.coordinator?.showsignInScreen()
        }
        alert.addAction(okAction)
        return alert
    }()
    
    
    func tapped() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped() {
        guard let email = email, let password = password, let name = name else {
            print("All fields are required.")
            return
        }
        let user = UserData(email: email, password: password, name: name)
        service.createUser(user: user) { result in
            switch result {
            case .success:
                self.present(self.alertVerification, animated: true, completion: nil)
            case .failure(let error):
                print("Failed to create user: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func loginButtonTapped() {
        coordinator?.showsignInScreen()
    }
    
    
        
        
        
        func setupConstraints() {
            singUpLabel.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
            }
            nameLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.top.equalTo(singUpLabel.snp.bottom).offset(30)
            }
            
            nameTextField.snp.makeConstraints { make in
                make.top.equalTo(nameLabel.snp.bottom).offset(5)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.height.equalTo(50)
            }
            
            emailLabel.snp.makeConstraints { make in
                make.top.equalTo(nameTextField.snp.bottom).offset(20)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
            }
            emailTextField.snp.makeConstraints { make in
                make.top.equalTo(emailLabel.snp.bottom).offset(5)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.height.equalTo(50)
            }
            passwordLabel.snp.makeConstraints { make in
                make.top.equalTo(emailTextField.snp.bottom).offset(20)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
            }
            passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(passwordLabel.snp.bottom).offset(5)
                make.left.equalToSuperview().offset(20)
                make.right.equalToSuperview().offset(-20)
                make.height.equalTo(50)
            }
            
            forgotPasswordButton.snp.makeConstraints { make in
                make.top.equalTo(passwordTextField.snp.bottom).offset(20)
                make.right.equalToSuperview().offset(-20)
            }
            
            
            signUpButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
                make.height.equalTo(50)
                make.width.equalTo(350)
            }
            
            signInWithLabel.snp.makeConstraints { make in
                make.top.equalTo(signUpButton.snp.bottom).offset(60)
                make.centerX.equalTo(signUpButton)
            }
            
            leftLine.snp.makeConstraints { make in
                make.centerY.equalTo(signInWithLabel)
                make.right.equalTo(signInWithLabel.snp.left).offset(-8)
                make.height.equalTo(1)
                make.width.equalTo(100)
            }
            
            rightLine.snp.makeConstraints { make in
                make.centerY.equalTo(signInWithLabel)
                make.left.equalTo(signInWithLabel.snp.right).offset(8)
                make.height.equalTo(1)
                make.width.equalTo(100)
            }
            
            googleButton.snp.makeConstraints { make in
                make.centerX.equalTo(signInWithLabel)
                make.top.equalTo(signInWithLabel.snp.bottom).offset(20)
                make.width.equalTo(320)
                make.height.equalTo(40)
            }
            
            facebookButton.snp.makeConstraints { make in
                make.centerX.equalTo(signInWithLabel)
                make.top.equalTo(googleButton.snp.bottom).offset(20)
                make.width.equalTo(320)
                make.height.equalTo(40)
            }
            
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    }

