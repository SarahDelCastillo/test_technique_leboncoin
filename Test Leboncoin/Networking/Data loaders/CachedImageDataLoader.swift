//
//  CachedImageDataLoader.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import UIKit

final class CachedImageDataLoader {
    private var cache = [URL: Data]()
    let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    func load(from url: URL) async -> Data? {
        if let data = cache[url] {
            return data
        }

        do {
            let (data, _) = try await httpClient.get(from: url)
            cache[url] = data
            return data
        } catch {
            return nil
        }
    }
}
