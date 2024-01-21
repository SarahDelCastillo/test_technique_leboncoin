//
//  HTTPClient.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL) async throws -> (Data, URLResponse) 
}
