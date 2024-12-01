//
//  ProfileViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//
import UIKit
import FirebaseAuth
import Firebase
import SnapKit


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var coordinator: ProfileCoordinator?

    private let tableView = UITableView()
    private let cellIdentifier = "ProfileOptionCell"

    // Данные для таблицы
    private let options = UserOption.options
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.background

        setupUI()
        setupConstraints()
        fetchUserData()
    }
    
    // MARK: - USER INFO
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
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
        button.setImage(UIImage(named: "Gicon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        button.layer.borderWidth = 1 // Ширина обводки
        button.layer.borderColor = AppColors.main.cgColor
        if let originalImage = UIImage(named: "Log out") {
            let resizedImage = originalImage.resized(to: CGSize(width: 26, height: 26))
            let tintedImage = resizedImage.withRenderingMode(.alwaysTemplate)
            button.setImage(resizedImage, for: .normal)
            button.tintColor = AppColors.main
        }
        return button
    }()
    
    // MARK: - Setup user info
    private func fetchUserData() {
        if let user = Auth.auth().currentUser {
            self.nameLabel.text = user.displayName ?? "No name"
            self.emailLabel.text = user.email
        }
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(tableView)
        view.addSubview(logOut)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = AppColors.background

    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(logOut.snp.top).offset(-25)
        }
        
        logOut.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
           // make.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-150) // Убедитесь, что кнопка видна
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
        cell.imageView?.tintColor = AppColors.main // Если используете SF Symbols
        cell.selectionStyle = .none
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row].title
       /* switch selectedOption{
        case "My Profile":
            
        default:
            break
        }*/
    }
}
