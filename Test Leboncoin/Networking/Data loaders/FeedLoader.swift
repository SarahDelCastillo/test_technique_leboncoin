//
//  FeedLoader.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import Foundation

private typealias CategoryLoader = DataLoader<[Category]>
private typealias APIItemLoader = DataLoader<[APIItem]>

protocol FeedLoader {
    func loadWithFilter(categoryId: Int?) async throws -> ([ListItem], [Category])
}

final class RemoteFeedLoader: FeedLoader {
    private let categoryLoader: CategoryLoader
    private let apiItemLoader: APIItemLoader

    private var apiItems = [APIItem]()
    private var categories = [Category]()

    init(client: HTTPClient) {
        self.categoryLoader = CategoryLoader(client: client, map: DataMapper.map)
        self.apiItemLoader = APIItemLoader(client: client, map: DataMapper.map)
    }

    func loadWithFilter(categoryId: Int?) async throws -> ([ListItem], [Category]) {
        async let apiItems = await loadAPIItems()
        async let categories = await loadCategories()

        // Check if there's a filter
        guard let categoryId = categoryId else {
            return try await (mapToListItem(items: apiItems, categories: categories), categories)
        }

        let filteredItems = try await apiItems.filter {
                $0.categoryId == categoryId
        }
        return try await (mapToListItem(items: filteredItems, categories: categories), categories)
    }

    private func loadAPIItems() async throws -> [APIItem] {
        // Return cached items
        // For the moment, cache is never invalidated. In a production app, this cache should be invalidated at some point.
        guard apiItems.isEmpty else { return apiItems }
        guard let itemsURL = URL(string: PlistValues.itemsURL) else { return [] }
        
        apiItems = try await apiItemLoader.loadData(from: itemsURL)
        return apiItems
    }

    private func loadCategories() async throws -> [Category] {
        // Return cached items
        // For the moment, cache is never invalidated. In a production app, this cache should be invalidated at some point.
        guard categories.isEmpty else { return categories }
        guard let categoriesURL = URL(string: PlistValues.categoriesURL) else { return [] }
        categories = try await categoryLoader.loadData(from: categoriesURL)
        return categories
    }

    private func mapToListItem(items: [APIItem], categories: [Category]) -> [ListItem] {
        let categoriesDictionary = categories.toDict()
        return items.sorted().map { item in
            let imageURL: URL? = if let urlString = item.imagesUrl["thumb"] {
                URL(string: urlString)
            } else {
                nil
            }

            let category = categoriesDictionary[item.categoryId] ?? "Inconnue"

            let dateString = DateFormatter.localizedString(from: item.creationDate, dateStyle: .medium, timeStyle: .short)

            return .init(title: item.title,
                         description: item.description,
                         date: dateString,
                         image: imageURL,
                         category: category,
                         price: item.price,
                         urgent: item.isUrgent)
        }
    }
}

private extension [APIItem] {
    func sorted() -> Self {
        var sorted = self
        sorted.sort {
            if $0.isUrgent != $1.isUrgent {
                return $0.isUrgent
            } else {
                return $0.creationDate < $1.creationDate
            }
        }
        return sorted
    }
}
