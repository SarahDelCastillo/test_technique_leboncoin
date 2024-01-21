//
//  CategoryLoader.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import Foundation

final class CategoryLoader {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func loadData() async -> [Category] {
        guard let url = URL(string: PlistValues.categoriesURL) else { return [] }
        
        do {
            let (data, _) = try await client.get(from: url)

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode([Category].self, from: data)
            return result
        } catch {
            return []
        }
    }
}
