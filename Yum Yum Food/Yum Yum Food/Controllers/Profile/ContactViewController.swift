//
//  ContactViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.12.2024.
//

import UIKit
import SnapKit

class ContactViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        setupUI()
        setupConstraints()
    }

    //MARK: - Setup UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact Us"
        label.font = .Rubick.bold.size(of: 40)
        label.textColor = AppColors.textColorMain
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Kyiv, Ukraine"
        label.font = .Rubick.regular.size(of: 20)
        label.textColor = AppColors.subTitleColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private lazy var emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Email Us: ruslanzhidkih@gmail.com", for: .normal)
        button.addTarget(self, action: #selector(emailUs), for: .touchUpInside)
        button.tintColor = AppColors.main
        button.titleLabel?.font = .Rubick.regular.size(of: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let socialMediaLabel: UILabel = {
        let label = UILabel()
        label.text = "Follow Me"
        label.font = .Rubick.bold.size(of: 20)
        label.textColor = AppColors.subTitleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let leftLine: UIView = {
        let line = UIView()
        line.backgroundColor = AppColors.main
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let rightLine: UIView = {
        let line = UIView()
        line.backgroundColor = AppColors.main
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private lazy var facebookButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Facebook", for: .normal)
        button.setTitleColor(AppColors.textColorMain, for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 20)
        
        if let image = UIImage(named: "facebook_icon")?.withRenderingMode(.alwaysOriginal) {
            button.setImage(image, for: .normal)
        }
        
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = AppColors.main
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 2
        button.layer.borderColor = AppColors.main.cgColor
        button.addTarget(self, action: #selector(openFacebook), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var instagramButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Instagram", for: .normal)
        button.setTitleColor(AppColors.textColorMain, for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 20)
        if let image = UIImage(named: "instagram_icon")?.withRenderingMode(.alwaysOriginal) {
            button.setImage(image, for: .normal)
        }
        
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = AppColors.main
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 2
        button.layer.borderColor = AppColors.main.cgColor
        button.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.text = "Meet Our Team"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamDescription: UILabel = {
        let label = UILabel()
        label.text = "I am an aspiring developer who is passionate about bringing food to your doorstep. My goal is to make your life more comfortable and delicious, with fast and reliable delivery of the food you love."
        label.font = .Rubick.regular.size(of: 18)
        label.textColor = AppColors.subTitleColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(addressLabel)
        view.addSubview(emailButton)
        view.addSubview(socialMediaLabel)
        view.addSubview(leftLine)
        view.addSubview(rightLine)
        view.addSubview(facebookButton)
        view.addSubview(instagramButton)
        view.addSubview(teamLabel)
        view.addSubview(teamDescription)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(view)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
       
        emailButton.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        teamLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(emailButton.snp.bottom).offset(20)
        }
        teamDescription.snp.makeConstraints { make in
            make.top.equalTo(teamLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        socialMediaLabel.snp.makeConstraints { make in
            make.top.equalTo(teamDescription.snp.bottom).offset(80)
            make.centerX.equalTo(view)
        }
        leftLine.snp.makeConstraints { make in
            make.centerY.equalTo(socialMediaLabel)
            make.right.equalTo(socialMediaLabel.snp.left).offset(-8)
            make.height.equalTo(1)
            make.width.equalTo(100)
        }
        
        rightLine.snp.makeConstraints { make in
            make.centerY.equalTo(socialMediaLabel)
            make.left.equalTo(socialMediaLabel.snp.right).offset(8)
            make.height.equalTo(1)
            make.width.equalTo(100)
        }
        
        facebookButton.snp.makeConstraints { make in
            make.top.equalTo(socialMediaLabel.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        instagramButton.snp.makeConstraints { make in
            make.top.equalTo(facebookButton.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }

    @objc private func emailUs() {
        if let url = URL(string: "mailto:ruslanzhidkih@gmail.com") {
            UIApplication.shared.open(url)
        }
    }

    @objc private func openFacebook() {
        if let url = URL(string: "https://facebook.com/your_profile") {
            UIApplication.shared.open(url)
        }
    }

    @objc private func openInstagram() {
        if let url = URL(string: "https://www.instagram.com/ruslanzhidkih?igsh=MWUzb2NpenRucDlzYw==") {
            UIApplication.shared.open(url)
        }
    }
}
