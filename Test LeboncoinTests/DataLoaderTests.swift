//
//  DataLoaderTests.swift
//  Test LeboncoinTests
//
//  Created by Sarah Del Castillo on 28/01/2024.
//

import XCTest
@testable import Test_Leboncoin

final class DataLoaderTests: XCTestCase {
    func test_loadData_sendsLoadMessage() async throws {
        let (sut, client) = makeSUT { _, _ in
            MockData.anyMockData()
        }
        let url = anyURL()

        _ = try await sut.loadData(from: url)
        
        XCTAssertEqual(client.receivedMessages, [.getFromURL])
    }

    func test_loadData_callsMapFunction() async throws {
        let exp = expectation(description: "Map function should be called")
        let (sut, _) = makeSUT { _, _ in
            exp.fulfill()
            return MockData.anyMockData()
        }

        let url = anyURL()

        _ = try await sut.loadData(from: url)

        await fulfillment(of: [exp], timeout: 1)
    }

    func test_loadData_throwsErrorOnClientError() async {
        let (sut, client) = makeSUT(map: { _,_ in
            MockData.anyMockData()
        })
        let url = anyURL()
        let testError = anyError()
        client.error = testError

        do {
            _ = try await sut.loadData(from: url)
            XCTFail("Should have failed.")
        } catch {
            XCTAssertEqual(error as NSError, testError)
        }
    }

    func test_loadData_throwsOnMapFunctionError() async {
        let testError = anyError()
        let (sut, _) = makeSUT(map: { _,_ -> MockData in
            throw testError
        })
        let url = anyURL()

        do {
            _ = try await sut.loadData(from: url)
            XCTFail("Should have failed.")
        } catch {
            XCTAssertEqual(error as NSError, testError)
        }
    }

    func makeSUT<T: Decodable>(map: @escaping (Data, HTTPURLResponse) throws -> T) -> (DataLoader<T>, MockHTTPClient) {
        let client = MockHTTPClient()
        let sut = DataLoader<T>(client: client, map: map)
        trackForMemoryLeaks(sut)
        return (sut, client)
    }
}

private struct MockData: Decodable {
    let testId: Int
    let testMessage: String

    static func anyMockData() -> MockData {
        MockData(testId: 0, testMessage: "message")
    }
}
