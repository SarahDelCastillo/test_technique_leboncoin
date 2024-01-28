//
//  DataLoader.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 28/01/2024.
//

import Foundation

final class DataLoader<T: Decodable> {
    private let client: HTTPClient
    private let map: (Data, HTTPURLResponse) throws -> T

    init(client: HTTPClient, map: @escaping (Data, HTTPURLResponse) throws -> T) {
        self.client = client
        self.map = map
    }

    func loadData(from url: URL) async throws -> T {
        let (data, response) = try await client.get(from: url).value
        return try map(data, response)
    }
}
