//
//  SearchViewController.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit
import SnapKit
import FirebaseFirestore

import UIKit
import FirebaseFirestore

class SearchViewController: UIViewController {
    weak var coordinator: SearchCoordinator?

    private let searchView = SearchView()
    private let searchModel = SearchModel()
    private var results: [FoodItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        setupSearchBar()
        setupTableView()
        setupKeyboardHandling()
    }

    private func setupSearchBar() {
        searchView.searchBar.delegate = self
        navigationItem.titleView = searchView.searchBar
    }

    private func setupTableView() {
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
    }

    private func setupKeyboardHandling() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func performSearch(query: String) {
        searchModel.searchFoodItems(query: query) { [weak self] (results, error) in
            guard let self = self else { return }
            if let error = error {
                print("Ошибка при поиске: \(error.localizedDescription)")
                return
            }
            self.results = results ?? []
            self.searchView.tableView.reloadData()
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            results.removeAll()
            searchView.tableView.reloadData()
        } else {
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
        cell.textLabel?.text = foodItem.name
        cell.detailTextLabel?.text = "Rating: \(foodItem.rating)"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
}
