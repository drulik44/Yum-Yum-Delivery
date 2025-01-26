//
//  HelpFAQViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 04.12.2024.
//

import UIKit
import SnapKit

class HelpFAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "faqCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    private let faqData = [
        ("General Questions".localized(), [
            "How to place an order?".localized(),
            "What payment methods are accepted?".localized(),
            "How to track my order?".localized(),
        ]),
        ("Delivery Questions".localized(), [
            "What are the delivery zones?".localized(),
            "How long does delivery take?".localized(),
            "What if my order is late?".localized()
        ]),
        ("Account & Profile".localized(), [
            "How to sign up?".localized(),
            "How to update account information?".localized(),
            "How to reset my password?".localized()
        ]),
        ("Payment Methods".localized(), [
            "What cards are accepted?".localized(),
            "Can I use PayPal or other methods?".localized()
        ]),
        ("Returns & Cancellations".localized(), [
            "How to cancel an order?".localized(),
            "How to request a refund?".localized()
        ]),
        ("Order Issues".localized(), [
            "What if my order is incorrect?".localized(),
            "What if the food is cold?".localized()
        ]),
        ("Discounts & Promotions".localized(), [
            "How to use promo codes?".localized(),
            "Are there any loyalty programs?".localized()
        ]),
        ("Contact Us".localized(), [
            "Support phone number".localized(),
            "Email address".localized(),
            "Social media links".localized()
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Help & FAQ".localized()
        view.backgroundColor = AppColors.background
        setupTableView()
        navigationController?.setupCustomBackButton(for: self)

    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return faqData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqData[section].1.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return faqData[section].0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath)
        cell.textLabel?.text = faqData[indexPath.section].1[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = AppColors.textColorMain
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        
        // Добавление тени для ячейки
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false

        return cell
    }

    // Устанавливаем высоту для заголовков секций
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    // Устанавливаем вид заголовков секций
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = AppColors.main
        
        let headerLabel = UILabel()
        headerLabel.text = faqData[section].0
        headerLabel.font = .boldSystemFont(ofSize: 18)
        headerLabel.textColor = .white
        
        headerView.addSubview(headerLabel)

        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerView).offset(16)
            make.trailing.equalTo(headerView).offset(-16)
            make.centerY.equalTo(headerView)
        }

        return headerView
    }
}

