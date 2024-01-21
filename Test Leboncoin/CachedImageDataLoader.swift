//
//  CachedImageDataLoader.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import UIKit

final class CachedImageDataLoader {
    private let cache = [URL: UIImage]()
    let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func load(from url: URL) async -> Data? {
        do {
            let (data, _) = try await httpClient.get(from: url)
            return data
        } catch {
            return nil
        }
    }
}
