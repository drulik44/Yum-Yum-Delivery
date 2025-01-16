//
//  SettingsViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.12.2024.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var coordinator: SettingsCoordinator?

    lazy var tableView = UITableView()

    var options: [SectionOptionSettings] = [
        SectionOptionSettings(name: "Language".localized(), icon: "Language Icons"),
        SectionOptionSettings(name: "Themecolor".localized(), icon: "Theme Icons 48"),
        SectionOptionSettings(name: "Setting up mailings".localized(), icon: "Notification Icon")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)
        navigationItem.title = "Settings".localized()
        
        setupTableView()
        setupConstaints()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseableId)
        
    }
    
    private func setupConstaints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    //MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseableId, for: indexPath) as! SettingsCell
        let option = options[indexPath.row]
        cell.setup(for: option)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    //MARK: - UITableViewDelegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case  0:
            self.coordinator?.showLocalizationVC()
            case  1:
            print ("Showing SettingsVC")
            case 2:
            self.coordinator?.showNotificationVC()
        default:
            break
        }
        }
    }

