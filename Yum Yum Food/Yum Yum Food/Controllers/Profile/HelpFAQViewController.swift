//
//  HelpFAQViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 04.12.2024.
//

import UIKit
import SnapKit

class HelpFAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView()
    private let faqData = [
        ("General Questions", [
            "How to place an order?",
            "What payment methods are accepted?",
            "How to track my order?"
        ]),
        ("Delivery Questions", [
            "What are the delivery zones?",
            "How long does delivery take?",
            "What if my order is late?"
        ]),
        ("Account & Profile", [
            "How to sign up?",
            "How to update account information?",
            "How to reset my password?"
        ]),
        ("Payment Methods", [
            "What cards are accepted?",
            "Can I use PayPal or other methods?"
        ]),
        ("Returns & Cancellations", [
            "How to cancel an order?",
            "How to request a refund?"
        ]),
        ("Order Issues", [
            "What if my order is incorrect?",
            "What if the food is cold?"
        ]),
        ("Discounts & Promotions", [
            "How to use promo codes?",
            "Are there any loyalty programs?"
        ]),
        ("Contact Us", [
            "Support phone number",
            "Email address",
            "Social media links"
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Help & FAQ"
        view.backgroundColor = AppColors.background
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "faqCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
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
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)

        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(headerView).offset(16)
            make.trailing.equalTo(headerView).offset(-16)
            make.centerY.equalTo(headerView)
        }

        return headerView
    }
}
