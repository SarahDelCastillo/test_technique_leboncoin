//
//  CachedImageDataLoaderTests.swift
//  Test LeboncoinTests
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import XCTest
@testable import Test_Leboncoin

final class CachedImageDataLoaderTests: XCTestCase {
    func test_loadFromURLReturnsNilOnEmptyDataResponse() async {
        let sut = makeSUT()
        let url = anyURL()

        let result = await sut.load(from: url)
        XCTAssertNil(result)
    }

    func makeSUT() -> CachedImageLoader {
        let httpClient = MockHTTPClient()
        let sut = CachedImageLoader(httpClient: httpClient)
        trackForMemoryLeaks(sut, file: #file, line: #line)
        return sut
    }
}

final class MockHTTPClient: HTTPClient {
    static var data = Data()
    static var response = HTTPURLResponse()

    static func setupWith(data: Data, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }

    func get(from url: URL) async throws -> (Data, URLResponse) {
        (Self.data, Self.response)
    }
}
