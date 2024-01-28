//
//  MockHTTPClient.swift
//  Test LeboncoinTests
//
//  Created by Sarah Del Castillo on 28/01/2024.
//

import XCTest
@testable import Test_Leboncoin

final class MockHTTPClient: HTTPClient {
    enum Message {
        case getFromURL
    }

    var receivedMessages = [Message]()
    var data = Data()
    var response = HTTPURLResponse()
    var error: NSError?

    func setupWith(data: Data, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }

    func get(from url: URL) -> Task<(Data, HTTPURLResponse), Error> {
        Task {
            receivedMessages.append(.getFromURL)
            if let error = error {
                throw error
            } else {
                return (data, response)
            }
        }
    }
}
