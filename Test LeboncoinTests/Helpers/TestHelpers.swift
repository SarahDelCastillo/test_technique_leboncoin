//
//  TestHelpers.swift
//  Test LeboncoinTests
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import Foundation

func anyURL() -> URL {
    URL(string: "www.example.com")!
}

func anyError() -> NSError {
    NSError(domain: "any error", code: 0)
}
