//
//  Double.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 22/01/2024.
//

import Foundation

extension Double {
    /// A computed property that returns the numeric value formatted as a string representing a price in euros.
    var asFormattedPrice: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return if let formattedPrice = numberFormatter.string(from: NSNumber(value: self)) {
            "\(formattedPrice) €"
        } else {
            ""
        }
    }
}
