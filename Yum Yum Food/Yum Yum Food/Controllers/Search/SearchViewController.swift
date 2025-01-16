//
//  SearchViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import SnapKit
import FirebaseFirestore

class SearchViewController: UIViewController, UITextFieldDelegate {
    weak var coordinator: SearchCoordinator?

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search".localized()
        searchBar.backgroundImage = UIImage() // Убирает границы
        searchBar.barTintColor = AppColors.background
        searchBar.tintColor = AppColors.textColorMain
        return searchBar
    }()
    
    private var results: [FoodItem] = [] // Массив для хранения результатов поиска
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FoodItemCell.self, forCellReuseIdentifier: "FoodItemCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = AppColors.background
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        setupUI()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120) // Измените по необходимости
            make.left.right.bottom.equalTo(view).inset(20)
        }
    }

    private func performSearch(query: String) {
        let db = Firestore.firestore()
        db.collection("fastest_delivery")
            .whereField("name", isGreaterThanOrEqualTo: query)
            .whereField("name", isLessThan: query + "\u{f8ff}")
            .getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    print("Ошибка при поиске: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("Нет данных для отображения")
                    return
                }
                let results = documents.map { doc -> FoodItem in
                    let data = doc.data()
                    return FoodItem(
                        name: data["name"] as? String ?? "",
                        rating: data["rating"] as? Double ?? 0.0,
                        deliveryTime: data["deliveryTime"] as? String ?? "",
                        imageUrl: data["imageUrl"] as? String ?? "",
                        deliveryPrice: data["deliveryPrice"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        nameRestaurant: "",
                        price: ""
                    )
                }
                self?.results = results // Обновляем результаты
                self?.tableView.reloadData() // Перезагружаем таблицу
            }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            print("Пользователь очистил поле поиска")
        } else {
            print("Поисковый запрос: \(searchText)")
            performSearch(query: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text, !query.isEmpty else { return }
        performSearch(query: query)
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodItemCell", for: indexPath)
        let foodItem = results[indexPath.row]
        
        // Настроить ячейку с данными
        cell.textLabel?.text = foodItem.name
        cell.detailTextLabel?.text = "Rating: \(foodItem.rating)"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    // Дополнительные методы для обработки выбора ячеек и других действий
}
