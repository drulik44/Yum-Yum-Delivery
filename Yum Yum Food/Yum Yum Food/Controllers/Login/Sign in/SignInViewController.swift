//
//  SignInViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 26.11.2024.
//


import UIKit
import SkyFloatingLabelTextField

class SignInViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordTextField.rightView = passwordToggleButton
            passwordTextField.rightViewMode = .always
        
        view.backgroundColor = AppColors.background
        setupAddToSuperview()
        setupConstraints()
        setupAccountSection()
        tapped()
    }
    
    //MARK: - Label
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of:32)
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
        label.text = "Don't have an account? "
        label.font = .Rubick.regular.size(of: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - TextField
    
    
    
    
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
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.main
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 15)
        button.setTitleColor(AppColors.main, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up ", for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 15)
        button.setTitleColor(AppColors.main, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    func setupAccountSection() {
        let containerView = UIStackView(arrangedSubviews: [accountLabel, signUpButton])
        containerView.axis = .horizontal
        containerView.spacing = 0
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
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
    
    //MARK: - Зробив кнопку Google
    
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
    
    func setupUI() {
        
    }
    
    func setupAddToSuperview() {
        view.addSubview(loginLabel)
        view.addSubview(loginButton)
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


    
    func tapped()  {
        signUpButton.addTarget(self, action: #selector (signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc func signUpButtonTapped() {
        coordinator?.showLoginScreen()
    }
    
    func setupConstraints() {
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(110)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
       
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(20)
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
        
        
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.width.equalTo(350)
        }
        
        signInWithLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(60)
            make.centerX.equalTo(loginButton)
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
}
