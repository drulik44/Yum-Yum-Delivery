//
//  SettingsViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.12.2024.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellIdentifier = "SettingsOptionCell"
    
    // Данные для таблицы
    private let settingsOptions = [
        ("Язык", ["English", "Русский", "Українська"]),
        ("Тема", ["Светлая", "Темная", "Системная"]),
        ("Рассылки", ["Подписаться на рассылку", "Отписаться от рассылки"])
    ]
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor.white
        return tv
    }()
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsOptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsOptions[section].1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let option = settingsOptions[indexPath.section].1[indexPath.row]
        cell.textLabel?.text = option
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = settingsOptions[indexPath.section].1[indexPath.row]
        print("Selected: \(selectedOption)")
        
        // Обработка выбора пользователя
        switch settingsOptions[indexPath.section].0 {
        case "Язык":
            // Логика изменения языка
            print("Изменить язык на \(selectedOption)")
        case "Тема":
            // Логика изменения темы
            print("Изменить тему на \(selectedOption)")
        case "Рассылки":
            // Логика управления рассылками
            print("\(selectedOption)")
        default:
            break
        }
    }
}
