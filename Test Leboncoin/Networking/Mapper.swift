//
//  Mapper.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 28/01/2024.
//

import Foundation

protocol Mapper {
    static func map<T: Decodable>(data: Data, from response: HTTPURLResponse) throws -> T
}

extension Mapper {
    static func map<T: Decodable>(data: Data, from response: HTTPURLResponse) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        guard response.isOK(), let decoded = try? decoder.decode(T.self, from: data) else {
            throw MapperError.invalidData
        }
        return decoded
    }
}

enum MapperError: Error {
    case invalidData
}
