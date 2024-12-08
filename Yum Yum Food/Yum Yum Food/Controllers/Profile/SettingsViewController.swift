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
        SectionOptionSettings(name: "Language", icon: "Language Icons"),
        SectionOptionSettings(name: "Themecolor", icon: "Theme Icons 48"),
        SectionOptionSettings(name: "Setting up mailings", icon: "Notification Icon")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)
        navigationItem.title = "Settings"
        
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseableId)
        //tableView.snp.makeConstraints { make in
           // make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            //make.right.equalToSuperview().offset(-5)
          //  make.left.equalToSuperview().offset(5)
           // make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-150)
        //}
    }
    // UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseableId, for: indexPath) as! SettingsCell
        let option = options[indexPath.row]
        cell.setup(for: option)
        return cell
    }

    // UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Логика при выборе ячейки
    }
}
