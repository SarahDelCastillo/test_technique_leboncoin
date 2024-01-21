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

    func test_loadFromURLReturnsLoadedData() async {
        let sut = makeSUT()
        let url = anyURL()
        let testData = anyData()

        MockHTTPClient.data = testData

        let result = await sut.load(from: url)
        XCTAssertEqual(result, testData)
    }

    func test_loadFromURLReturnsNilOnClientError() async {
        let sut = makeSUT()
        let url = anyURL()
        let error = anyError()

        MockHTTPClient.error = error

        let result = await sut.load(from: url)
        XCTAssertNil(result)
    }

    func makeSUT() -> CachedImageDataLoader {
        let httpClient = MockHTTPClient()
        let sut = CachedImageDataLoader(httpClient: httpClient)
        trackForMemoryLeaks(sut, file: #file, line: #line)
        return sut
    }
}

final class MockHTTPClient: HTTPClient {
    static var data = Data()
    static var response = HTTPURLResponse()
    static var error: NSError?

    static func setupWith(data: Data, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }

    func get(from url: URL) async throws -> (Data, URLResponse) {
        if let error = Self.error {
            throw error
        } else {
            (Self.data, Self.response)
        }
    }
}
