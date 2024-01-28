//
//  URLSessionHTTPClientTests.swift
//  Test LeboncoinTests
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import XCTest
@testable import Test_Leboncoin

final class URLSessionHTTPClientTests: XCTestCase {
    override class func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }

    func test_getFromURL_performsGETRequestWithURL() async throws {
        let sut = makeSUT()
        let url = anyURL()

        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
        }

        _ = try await sut.get(from: url).value
    }

    func test_getFromURL_failsOnRequestError() async {
        let sut = makeSUT()
        let url = anyURL()
        let testError = anyError()

        URLProtocolStub.stub(data: nil, response: nil, error: testError)

        do {
            _ = try await sut.get(from: url).value
            XCTFail("Should have failed with error.")
        } catch {
            let receivedError = error as NSError
            XCTAssertEqual(receivedError.code, testError.code
            )
        }
    }

    func test_getFromURL_succeedsOnHTTPURLResponseWithData() async {
        let sut = makeSUT()
        let url = anyURL()
        let testData = anyData()
        let testResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        URLProtocolStub.stub(data: testData, response: testResponse, error: nil)

        do {
            let (data, response) = try await sut.get(from: url).value
            XCTAssertEqual(data, testData)
            XCTAssertEqual(response.url, url)

        } catch {
            XCTFail("Should not have thrown")
        }
    }

    func test_getFromURLReturnsEmptyDataOnResponseWithNilData() async {
        let sut = makeSUT()
        let url = anyURL()
        let emptyData = Data()

        URLProtocolStub.stub(data: nil, response: nil, error: nil)

        do {
            let (data, _) = try await sut.get(from: url).value
            XCTAssertEqual(data, emptyData)
        } catch {
            XCTFail("Should not have failed.")
        }
    }

    func test_cancelGetFromURLTask_cancelsURLRequest() async {
        let sut = makeSUT()
        let url = anyURL()

        URLProtocolStub.stub(data: nil, response: nil, error: nil)

        let task = sut.get(from: url)
        task.cancel()

        do {
            _ = try await task.value
            XCTFail("Should have failed")
        } catch let error as NSError {
            XCTAssertEqual(error.code, URLError.cancelled.rawValue)
        }
    }

    private func makeSUT() -> HTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]

        let session = URLSession(configuration: configuration)
        let sut = URLSessionHTTPClient(session: session)
        trackForMemoryLeaks(sut, file: #file, line: #line)
        return sut
    }
}
