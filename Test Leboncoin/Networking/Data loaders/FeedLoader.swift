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

    init() {
        let client = URLSessionHTTPClient(session: .shared)
        self.categoryLoader = CategoryLoader(client: client)
        self.apiItemLoader = APIItemLoader(client: client)
    }

    func loadItems() async -> [ListItem] {
        async let categories = categoryLoader.loadData()
        async let items = apiItemLoader.loadData()

        return await mapToListItem(items: items, categories: categories)
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
