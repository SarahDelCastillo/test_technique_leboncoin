//
//  HTTPURLResponse.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 28/01/2024.
//

import Foundation

extension HTTPURLResponse {
    func isOK() -> Bool {
        (200...299).contains(statusCode)
    }
}
