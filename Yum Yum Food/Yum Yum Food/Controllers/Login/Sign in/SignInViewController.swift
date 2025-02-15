//
//  SignInViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 26.11.2024.
//


import UIKit
import SkyFloatingLabelTextField

class SignInViewController: UIViewController, UITextFieldDelegate {
    weak var coordinator: MainCoordinator?
    private let service = AuthService()
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
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.backgroundColor = AppColors.background
        setupAddToSuperview()
        setupConstraints()
        setupAccountSection()
        tapped()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
    
    let googleButton = GoogleButton()
        
    let facebookButton = FacebookButton()

    
    //MARK: - Lazy alert
    
    lazy var alertEmpty : UIAlertController = {
        let alert = UIAlertController(title: "Error", message: "Email or password are empty", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        return alert
    }()
    
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
    
    @objc private func loginButtonTapped() {
        guard let email = email, let password = password else {
            //print("Email and password are empty")
            self.present(self.alertEmpty, animated: true)
            return
        }
        let user = UserData(email: email, password: password, name: nil)
        service.signIn(user: user) { result in
            switch result {
            case .success:
                print("User signed in successfully.")
                self.coordinator?.showMainTabBar() // Перейти на главный экран
            case .failure(let error):
                print("Failed to sign in: \(error.localizedDescription)")
                self.present(self.alertEmpty, animated: true)

            }
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
