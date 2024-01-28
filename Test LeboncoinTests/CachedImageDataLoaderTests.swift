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
        let (sut, _) = makeSUT()
        let url = anyURL()

        let result = await sut.load(from: url)
        XCTAssertNil(result)
    }

    func test_loadFromURLReturnsLoadedData() async {
        let (sut, client) = makeSUT()
        let url = anyURL()
        let testData = anyData()

        client.data = testData

        let result = await sut.load(from: url)
        XCTAssertEqual(result, testData)
    }

    func test_loadFromURLReturnsNilOnClientError() async {
        let (sut, client) = makeSUT()
        let url = anyURL()
        let error = anyError()

        client.error = error

        let result = await sut.load(from: url)
        XCTAssertNil(result)
    }

    func test_loadFromURLLoadsFromCacheIfThereIsOne() async {
        let (sut, client) = makeSUT()
        let url = anyURL()
        let data = anyData()

        client.data = data

        _ = await sut.load(from: url)
        XCTAssert(client.receivedMessages.count == 1)

        // Reset client data
        client.data = Data()

        let result = await sut.load(from: url)
        XCTAssert(client.receivedMessages.count == 1)
        XCTAssertEqual(result, data)
    }

    func makeSUT() -> (CachedImageDataLoader, MockHTTPClient) {
        let httpClient = MockHTTPClient()
        let sut = CachedImageDataLoader(httpClient: httpClient)
        trackForMemoryLeaks(sut, file: #file, line: #line)
        return (sut, httpClient)
    }
}
