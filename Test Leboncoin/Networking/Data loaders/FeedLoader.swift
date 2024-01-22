//
//  FeedLoader.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import Foundation

final class FeedLoader {
    private let categoryLoader: CategoryLoader
    private let apiItemLoader: APIItemLoader

    private var apiItems = [APIItem]()
    private var categories = [Category]()

    init() {
        let client = URLSessionHTTPClient(session: .shared)
        self.categoryLoader = CategoryLoader(client: client)
        self.apiItemLoader = APIItemLoader(client: client)
    }

    func loadWithFilter(categoryId: Int?) async -> ([ListItem], [Category]) {
        async let apiItems = await loadAPIItems()
        async let categories = await loadCategories()

        guard let categoryId = categoryId else {
            return await (mapToListItem(items: apiItems, categories: categories), categories)
        }

        let filteredItems = await apiItems.filter {
                $0.categoryId == categoryId
        }
        return await (mapToListItem(items: filteredItems, categories: categories), categories)
    }

    private func loadAPIItems() async -> [APIItem] {
        apiItems = apiItems.isEmpty ? await apiItemLoader.loadData() : apiItems
        return apiItems
    }

    private func loadCategories() async -> [Category] {
        categories = categories.isEmpty ? await categoryLoader.loadData() : categories
        return categories
    }

    private func mapToListItem(items: [APIItem], categories: [Category]) -> [ListItem] {
        items.map { item in
            let imageURL: URL? = if let urlString = item.imagesUrl["thumb"] {
                URL(string: urlString)
            } else {
                nil
            }

            let category = categories.first { $0.id == item.categoryId }?.name ?? "Inconnue"
            let dateString: String = if let date = item.creationDateExtracted {
                DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
            } else {
                ""
            }

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
