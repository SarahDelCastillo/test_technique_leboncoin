//
//  APIItemLoader.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import Foundation

final class APIItemLoader {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func loadData() async -> [APIItem] {
        guard let url = URL(string: PlistValues.itemsURL) else { return [] }

        do {
            let (data, _) = try await client.get(from: url).value
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode([APIItem].self, from: data)
            return result
        } catch {
            return []
        }
    }
}
