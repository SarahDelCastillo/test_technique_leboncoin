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
            let (data, response) = try await httpClient.get(from: url).value
            guard let imageData = handleClientResponse(data: consume data, response: response) else { return nil }

            cache[url] = imageData
            return imageData
        } catch {
            return nil
        }
    }

    private func handleClientResponse(data: Data, response: URLResponse) -> Data? {
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200,
              !data.isEmpty
        else { return nil }

        return data
    }
}
