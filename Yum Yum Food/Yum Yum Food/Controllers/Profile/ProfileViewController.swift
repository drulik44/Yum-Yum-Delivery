//
//  ProfileViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import SnapKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var coordinator: ProfileCoordinator?
    private let service = AuthService()
    
    private let cellIdentifier = "ProfileOptionCell"
    
    private let options = UserOption.options
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = AppColors.background
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        fetchUserData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileUpdated), name: NSNotification.Name("UserProfileUpdated"), object: nil)
    }
    
    // MARK: - USER INFO
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50 // Половина ширины/высоты для круговой маски
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = AppColors.main.cgColor
        imageView.image = UIImage(named: "Profile imageView")
        imageView.tintColor = AppColors.gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.gray
        label.font = .Rubick.regular.size(of: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logOut: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(AppColors.main, for: .normal)
        button.titleLabel?.font = .Rubick.regular.size(of: 18)
        button.imageView?.contentMode = .scaleAspectFit
        
        // Установка обводки
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
    
    // MARK: - Setup user info
    
    private func fetchUserData() {
        if let user = Auth.auth().currentUser {
            let userRef = Firestore.firestore().collection("users").document(user.uid)
            userRef.getDocument { document, error in
                if let error = error {
                    print("Ошибка получения данных пользователя: \(error.localizedDescription)")
                    return
                }
                
                guard let document = document, document.exists, let data = document.data() else { return }
                self.nameLabel.text = data["name"] as? String ?? "No name"
                self.emailLabel.text = data["email"] as? String
                
                
                
                }
            }
        }
    
    
    @objc private func userProfileUpdated() {
        fetchUserData()
    }
    
    
  

    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tv.showsVerticalScrollIndicator = false
        tv.scrollsToTop = false
        tv.separatorColor = UIColor.clear
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = AppColors.background
        return tv
    }()
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(tableView)
        view.addSubview(logOut)
        
        logOut.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
    }
    
    // MARK: - Setup Constraints
    
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
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-75)
        }
        
        logOut.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50) // Убедитесь, что кнопка
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let option = options[indexPath.row]
        cell.textLabel?.text = option.title
        cell.imageView?.image = option.icon
        cell.textLabel?.font = .Rubick.regular.size(of: 18)
        cell.textLabel?.textColor = AppColors.textColorMain
        cell.imageView?.tintColor = AppColors.main
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row].title
        DispatchQueue.main.async {
            switch selectedOption {
            case "My Profile":
                self.coordinator?.showUserProfile()
            case "My Orders":
                self.coordinator?.showOrderScreen()
            case "Delivery Address":
                self.coordinator?.showDeliveryScreen()
            case "Payments Methods":
                self.coordinator?.showPaymentsScreen()
            case "Contact Us":
                self.coordinator?.showContactScreen()
            case "Settings":
                self.coordinator?.showSettingsScreen()
            case "Help & FAQ":
                self.coordinator?.showHelpScreen()
            default:
                break
            }
        }
    }
    
    // MARK: - Log Out
    
    @objc private func logOutTapped() {
        do {
            try Auth.auth().signOut()
            coordinator?.showWelcomeScreen() // Переход к экрану входа
        } catch let error as NSError {
            print("Ошибка выхода из аккаунта: \(error.localizedDescription)")
        }
    }
}




