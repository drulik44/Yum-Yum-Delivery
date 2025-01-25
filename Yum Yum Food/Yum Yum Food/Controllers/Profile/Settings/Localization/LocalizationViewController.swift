//
//  LocalizationViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 15.01.2025.
//

import UIKit
import SnapKit

class LocalizationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    weak var coordinator: SettingsCoordinator?
    lazy var tableView = UITableView()

    var options: [SectionOptionSettings] = [
        SectionOptionSettings(name: "English", icon: "English Icons 48"),
        SectionOptionSettings(name: "Українська", icon: "Ukraine Icons 48"),
    ]

    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = AppColors.main
        view.hidesWhenStopped = true
        return view
    }()

    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupConstraints()
    }

    private func setupUI() {
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)
        navigationItem.title = "Language".localized()

        view.addSubview(tableView)
        view.addSubview(overlayView)
        view.addSubview(indicatorView)
        
        view.bringSubviewToFront(overlayView)
        view.bringSubviewToFront(indicatorView)
        overlayView.isUserInteractionEnabled = true
    }

    private func setupTableView() {
        //view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseableId)
        tableView.backgroundColor = AppColors.background
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.right.bottom.equalToSuperview()
        }
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setLanguage(to language: String) {
        overlayView.isHidden = false
        view.bringSubviewToFront(indicatorView)
        indicatorView.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            
            UserDefaults.standard.set(language, forKey: "AppLanguage")
            UserDefaults.standard.synchronize()

            self.overlayView.isHidden = true
            self.indicatorView.stopAnimating()

            NotificationCenter.default.post(name: .init("ReloadRootViewController"), object: nil)
            NotificationCenter.default.post(name: .init("ReloadLocalizedStrings"), object: nil)
        }
    }

    // MARK: - UITableViewDataSource Methods
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


    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            setLanguage(to: "en")
        case 1:
            setLanguage(to: "uk")
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
