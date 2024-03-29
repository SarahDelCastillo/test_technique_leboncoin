//
//  HomeViewController.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 18/01/2024.
//

import UIKit

final class HomeViewController: UITableViewController {
    private(set) var items = [ListItem]()

    var loadWithFilter: ((_ categoryId: Int?) async throws -> ([ListItem], [Category]))?
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

        setupLoadingView()
        setupTableView()
        setupRefreshControl()
        updateTitle()

        navigationItem.rightBarButtonItem = filterButton
        Task {
            await self.loadIntoTableView()
        }
    }

    private func loadIntoTableView() async {
        guard let loadWithFilter else {
            loaderView.updateState(.error)
            return
        }

        loaderView.updateState(.loading)
        items = []
        tableView.reloadData()
        do {
            let (items, categories) = try await loadWithFilter(currentFilter)
            self.items = items
            self.categories = categories

            loaderView.updateState(items.isEmpty ? .noItems : .loaded)
            tableView?.reloadData()
            
            guard !self.items.isEmpty else { return }
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        } catch {
            loaderView.updateState(.error)
        }
    }

    private func updateTitle() {
        if let currentFilter {
            title = categories.categoryName(for: currentFilter)
        } else {
            title = "Tout"
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
        vc.currentCategory = currentFilter
        vc.didSelectCategory = { [weak self] categoryId in
            self?.currentFilter = categoryId
            self?.updateTitle()
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
    let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    let remoteFeedLoader = RemoteFeedLoader(client: client)
    let rootVC = HomeViewController()
    rootVC.loadWithFilter = remoteFeedLoader.loadWithFilter
    return UINavigationController(rootViewController: HomeViewController())
}
