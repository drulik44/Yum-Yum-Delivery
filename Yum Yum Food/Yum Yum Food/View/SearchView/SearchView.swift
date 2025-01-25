//
//  SearchView.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 25.01.2025.
//


import UIKit
import SnapKit

class SearchView: UIView {
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search".localized()
        searchBar.backgroundImage = UIImage() // Убирает границы
        searchBar.barTintColor = AppColors.background
        searchBar.tintColor = AppColors.textColorMain
        return searchBar
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FoodItemCell.self, forCellReuseIdentifier: "FoodItemCell")
        tableView.backgroundColor = AppColors.background
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = AppColors.background
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120) // Измените по необходимости
            make.left.right.bottom.equalToSuperview().inset(20)
        }
    }
}