//
//  SearchViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    weak var coordinator: SearchCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        setupUI()
    }

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundImage = UIImage() // Убирает границы
        searchBar.barTintColor = AppColors.background
        searchBar.tintColor = AppColors.textColorMain
        return searchBar
    }()

   

   
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(searchBar)

        setupConstraints()
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(40)
        }

       
    }

    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Показать клавиатуру при нажатии на текстовое поле
        textField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Скрыть клавиатуру при нажатии на Return
        textField.resignFirstResponder()
        return true
    }
}

