//
//  WelcomeViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        addToSuperview()
        setupConstraints()
        setupAccountSection()
        startWithEmailButton.addTarget(self, action: #selector(startWithEmailButtonTapped), for: .touchUpInside)

        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to \nYum Yum Food"
        label.font = .Rubick.bold.size(of: 40)
        label.textColor = AppColors.textColorMain
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get your favourite meals delivered quickly right to your doorstep"
        label.font = .Rubick.regular.size(of: 18)
        label.textColor = AppColors.subTitleColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let startWithEmailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start with email", for: .normal)
        button.backgroundColor = AppColors.textColorMain
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 18)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    //MARK: - Створюю в самому низу надпис з входом
    
    let accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account? "
        label.font = .Rubick.regular.size(of: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 15)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    func setupAccountSection() {
        let containerView = UIStackView(arrangedSubviews: [accountLabel, signInButton])
        containerView.axis = .horizontal
        containerView.spacing = 0
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(facebookButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "WelcomePhoto")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.9 
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [
            AppColors.background.withAlphaComponent(0.8).cgColor,
            AppColors.main.withAlphaComponent(0.8).cgColor
        ]
        gradientLayer.locations = [0.0, 0.9, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        view.layer.insertSublayer(gradientLayer, above: backgroundImage.layer)
    }
    
    func addToSuperview() {
        view.addSubview(welcomeLabel)
        view.addSubview(startWithEmailButton)
        view.addSubview(subTitleLabel)
        view.addSubview(signInWithLabel)
        view.addSubview(leftLine)
        view.addSubview(rightLine)
        view.addSubview(googleButton)
        view.addSubview(facebookButton)
    }
    
    
    
    func setupConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        startWithEmailButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
        
        signInWithLabel.snp.makeConstraints { make in
            make.top.equalTo(startWithEmailButton.snp.bottom).offset(90)
            make.centerX.equalTo(startWithEmailButton)
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
            make.top.equalTo(signInWithLabel.snp.bottom).offset(50)
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
    
    //MARK: - Функціі для натискання
    
    @objc func startWithEmailButtonTapped() {
        coordinator?.showLoginScreen()
    }
    
    @objc func signInButtonTapped() {
        coordinator?.showsignInScreen()
    }
    
    
}
