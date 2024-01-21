//
//  Bundle.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 21/01/2024.
//

import Foundation

extension Bundle {
    /// A convenient way to access the `Bundle` associated with the current context.
    static var current: Bundle {
        class __ {}
        return Bundle(for: __.self)
    }
}
