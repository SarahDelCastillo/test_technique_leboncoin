//
//  APIItemMapperTests.swift
//  Test LeboncoinTests
//
//  Created by Sarah Del Castillo on 28/01/2024.
//

import XCTest
@testable import Test_Leboncoin

final class MapperTests: XCTestCase {
    private typealias TestedMapper = (Data, HTTPURLResponse) throws -> MockData

    func test_map_throwsErrorWhenResponseNotOK() {
        let sut: TestedMapper = TestMapper.map
        let errorResponse = HTTPURLResponse(url: anyURL(), statusCode: 400, httpVersion: nil, headerFields: nil)!
        let data = anyData()

        do {
            _ = try sut(data, errorResponse)
            XCTFail("Should have failed")
        } catch {
            XCTAssertEqual(error as! MapperError, .invalidData)
        }
    }

    func test_map_throwsErrorWhenDataCorrectButResponseNotOK() {
        let sut: TestedMapper = TestMapper.map
        let errorResponse = HTTPURLResponse(url: anyURL(), statusCode: 400, httpVersion: nil, headerFields: nil)!
        let data = "{ test_id: 1, test_message: \"message\"}".data(using: .utf8)!

        do {
            _ = try sut(data, errorResponse)
            XCTFail("Should have failed")
        } catch {
            XCTAssertEqual(error as! MapperError, .invalidData)
        }
    }


    func test_map_returnsDecodedData() {
        let sut: TestedMapper = TestMapper.map
        let okResponse = HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = "{ test_id: 1, test_message: \"message\"}".data(using: .utf8)!

        do {
            let result = try sut(data, okResponse)
            XCTAssertEqual(result, MockData(testId: 1, testMessage: "message"))
        } catch {
            print(error)
        }
    }

    func test_map_throwsErrorOnInvalidData() {
        let sut: TestedMapper = TestMapper.map
        let okResponse = HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
        let data = "invalid".data(using: .utf8)!

        do {
            let result = try sut(data, okResponse)
            XCTFail("Should have failed")
        } catch {
            XCTAssertEqual(error as! MapperError, .invalidData)
        }
    }
}

private struct MockData: Equatable, Decodable {
    let testId: Int
    let testMessage: String
}

private struct TestMapper: Mapper {}
