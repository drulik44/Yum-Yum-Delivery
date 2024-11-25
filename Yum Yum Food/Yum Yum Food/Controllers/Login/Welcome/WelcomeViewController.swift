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
        
    }
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to \nYum Yum Food"
        label.font = .Rubick.bold.size(of:  40)
        label.textColor = AppColors.textColorMain
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get your favourite meals delivered quickly right to your doorstep"
        label.font = .Rubick.regular.size(of:  18)
        label.textColor = AppColors.subTitleColor
        //UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)
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
    
    let googleButto = UIButton()
    
    func setupBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "WelcomePhoto")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.9 // Устанавливаем прозрачность на 50%
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
    }
    
    func setupConstraints() {
        
        welcomeLabel.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-20)
            
            subTitleLabel.snp.makeConstraints { make in make.top.equalTo(welcomeLabel.snp.bottom).offset(20); make.left.equalToSuperview().offset(30);
                make.right.equalToSuperview().offset(-30)
            }
            
            startWithEmailButton.snp.makeConstraints { make in make.top.equalTo(subTitleLabel.snp.bottom).offset(50)
                make.left.equalToSuperview().offset(30)
                make.right.equalToSuperview().offset(-30)
                make.height.equalTo(50)
            }
            
        }


    }
    
    }


