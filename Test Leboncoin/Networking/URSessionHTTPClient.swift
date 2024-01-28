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

    private struct UnexpectedValuesRepresentation: Error {}

    func get(from url: URL) -> Task<(Data, HTTPURLResponse), Error> {
        Task {
            let (data, response) = try await session.data(from: url)
            if let response = response as? HTTPURLResponse {
                return (data, response)
            } else {
                throw UnexpectedValuesRepresentation()
            }
        }
    }
}
