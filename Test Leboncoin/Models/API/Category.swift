//
//  Category.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 20/01/2024.
//

struct Category: Decodable {
    var id: Int
    var name: String
}

extension [Category] {
    func categoryName(for id: Int) -> String? {
        self.first { $0.id == id }?.name
    }
}

extension [Category] {
    func toDict() -> [Int: String] {
        Dictionary(uniqueKeysWithValues: self.map { ($0.id, $0.name) })
    }
}
