//
//  HomeViewController.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 18/01/2024.
//

import UIKit

final class HomeViewController: UITableViewController {
    private(set) var items = [ListItem]()

    private var feedLoader: FeedLoader?
    private var categories = [Category]()
    private var currentFilter: Int? {
        didSet {
            Task {
                await loadIntoTableView()
            }
        }
    }
    private lazy var filterButton = {
        UIBarButtonItem(title: "Catégories", style: .plain, target: self, action: #selector(presentCategoriesSheet))
    }()
    private let loaderView = LoadingView(forAutoLayout: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedLoader = FeedLoader()

        setupLoadingView()
        setupTableView()
        setupRefreshControl()

        navigationItem.rightBarButtonItem = filterButton
        Task {
            loaderView.updateState(.loading)
            await self.loadIntoTableView()
        }
    }

    private func loadIntoTableView() async {
        if let (items, categories) = await feedLoader?.loadWithFilter(categoryId: currentFilter) {
            self.items = items
            self.categories = categories

            loaderView.updateState(items.isEmpty ? .noItems : .loaded)
            tableView?.reloadData()
        }
    }

    private func setupLoadingView() {
        view.addSubview(loaderView)

        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func setupTableView() {
        tableView.register(ListItemCell.self, forCellReuseIdentifier: "itemCell")
        tableView.separatorStyle = .none
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    @objc private func refresh() {
        Task {
            await loadIntoTableView()
            refreshControl?.endRefreshing()
        }
    }

    @objc private func presentCategoriesSheet() {
        let vc = CategoriesList()
        vc.loadCategories = { [weak self] in
            self?.categories ?? []
        }
        vc.didSelectCategory = { [weak self] categoryId in
            self?.currentFilter = categoryId
        }
        vc.modalPresentationStyle = .automatic
        present(vc, animated: true)
    }

    func presentDetailView(for item: ListItem) {
        let vc = ItemDetailViewController()
        vc.setupWithItem(item)
        present(vc, animated: true)
    }
}

@available(iOS 17, *)
#Preview {
    UINavigationController(rootViewController: HomeViewController())
}
