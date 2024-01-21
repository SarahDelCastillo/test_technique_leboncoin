//
//  AsyncUIImageView.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import UIKit

final class AsyncUIImageView: UIImageView {
    private static let cachedImageDataLoader = {
        let client = URLSessionHTTPClient(session: .shared)
        return CachedImageDataLoader(httpClient: client)
    }()

    func load(from url: URL) -> Task<Void, Error> {
        setPlaceholder()
        return Task {
            if let loadedImageData = await Self.cachedImageDataLoader.load(from: url) {
                image = UIImage(data: loadedImageData)
            }
        }
    }

    private func setPlaceholder() {
        image = UIImage(named: "placeholder")
    }
}
