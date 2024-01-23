//
//  CategoriesList.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import UIKit

final class CategoriesList: UIViewController {
    private let titleLabel = UILabel(forAutoLayout: true)
    private let tableView = UITableView(forAutoLayout: true)
    private var categories = [Category]()
    private let clearButton = UIButton(forAutoLayout: true)

    var didSelectCategory: ((Int?) -> ())?
    var loadCategories: (() -> [Category])?


    override func viewDidLoad() {
        self.title = "Catégories"
        view.backgroundColor = .systemBackground

        categories = loadCategories?() ?? []
        setupTitleLabel()
        setupTableView()
        setupClearButton()
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: .title3)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
        ])
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            tableView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 1)
        ])
    }

    private func setupClearButton() {
        view.addSubview(clearButton)
        // For some reason the button title color is white, hence the need to set it manually here
        clearButton.setTitleColor(.orange, for: .normal)
        clearButton.setTitleColor(.gray, for: .highlighted)
        
        clearButton.setTitle("Effacer", for: .normal)
        clearButton.addTarget(self, action: #selector(clearFilter), for: .touchUpInside)

        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func clearFilter() {
        didSelectCategory?(nil)
        dismiss(animated: true)
    }
}

extension CategoriesList: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") ?? UITableViewCell(style: .default, reuseIdentifier: "categoryCell")

        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = categories[indexPath.row].name
        cell.contentConfiguration = contentConfiguration
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryID = categories[indexPath.row].id

        didSelectCategory?(categoryID)
        dismiss(animated: true)
    }
}

@available(iOS 17, *)
#Preview {
    let categoriesList = {
        let categoriesList = CategoriesList()
        categoriesList.loadCategories = {
            [
                .init(id: 0, name: "Immobilier"),
                .init(id: 1, name: "Véhicules"),
                .init(id: 2, name: "Loisirs")
            ]
        }
        return categoriesList
    }()
    return categoriesList
}
