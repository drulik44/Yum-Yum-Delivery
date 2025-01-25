//
//  ProfileViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var coordinator: ProfileCoordinator?
    
    private let profileView = ProfileView()
    private let profileModel = ProfileModel()
    
    private var options = UserOption.options
    
    override func loadView() {
        super.loadView()
        view = profileView
        view.backgroundColor = AppColors.background
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.tableView.delegate = self
        profileView.tableView.dataSource = self
        profileView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileOptionCell")
        
        profileView.logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        
        fetchUserData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileUpdated), name: NSNotification.Name("UserProfileUpdated"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .init("ReloadRootViewController"), object: nil)
    }
    
    @objc private func updateLocalizedStrings() {
        print("Updating localized strings")
        reloadOptions()
        DispatchQueue.main.async {
            self.profileView.tableView.reloadData()
        }
    }
    
    private func fetchUserData() {
        profileModel.fetchUserData { [weak self] name, email in
            guard let self = self else { return }
            self.profileView.nameLabel.text = name
            self.profileView.emailLabel.text = email
        }
    }
    
    @objc private func userProfileUpdated() {
        fetchUserData()
    }
    
    private func reloadOptions() {
        options = [
            UserOption(title: "My Profile".localized(), icon: UIImage(named: "profile vc")),
            UserOption(title: "My Orders".localized(), icon: UIImage(named: "order")),
            UserOption(title: "Delivery Address".localized(), icon: UIImage(named: "delivery address")),
            UserOption(title: "Payments Methods".localized(), icon: UIImage(named: "wallet")),
            UserOption(title: "Contact Us".localized(), icon: UIImage(named: "contact")),
            UserOption(title: "Settings".localized(), icon: UIImage(named: "settings")),
            UserOption(title: "Help & FAQ".localized(), icon: UIImage(systemName: "questionmark.circle.fill"))
        ]
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileOptionCell", for: indexPath)
        let option = options[indexPath.row]
        cell.textLabel?.text = option.title.localized()
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
        let selectedOption = options[indexPath.row].title.localized()
        DispatchQueue.main.async {
            switch selectedOption {
            case "My Profile".localized():
                self.coordinator?.showUserProfile()
            case "My Orders".localized():
                self.coordinator?.showOrderScreen()
            case "Delivery Address".localized():
                self.coordinator?.showDeliveryScreen()
            case "Payments Methods".localized():
                self.coordinator?.showPaymentsScreen()
            case "Contact Us".localized():
                self.coordinator?.showContactScreen()
            case "Settings".localized():
                self.coordinator?.showSettingsScreen()
            case "Help & FAQ".localized():
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
            coordinator?.showWelcomeScreen()
        } catch let error as NSError {
            print("Ошибка выхода из аккаунта: \(error.localizedDescription)")
        }
    }
}
