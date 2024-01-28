//
//  URSessionHTTPClient.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {
    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func get(from url: URL) -> Task<(Data, URLResponse), Error> {
        Task {
            try await session.data(from: url)
        }
    }
}
