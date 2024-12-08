//
//  PaymentsViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 03.12.2024.
//

import UIKit
import SnapKit

class PaymentsViewController: UIViewController {
    weak var coordinator: ProfileCoordinator?

    private var options = paymentMethodData

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)
        setupUI()
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textColorMain
        label.font = .Rubick.bold.size(of: 30) 
        label.textAlignment = .left
        label.text = "Payment Methods"
        return label
    }()

    private lazy var paymentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PaymentOptionCell.self, forCellReuseIdentifier: PaymentOptionCell.reuseableId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(paymentTableView)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }

        paymentTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentOptionCell.reuseableId, for: indexPath) as! PaymentOptionCell
        let option = options[indexPath.row]
        cell.setup(for: option)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (index, _) in options.enumerated() {
            options[index].selected = index == indexPath.row
        }
        tableView.reloadData()
    }
}
