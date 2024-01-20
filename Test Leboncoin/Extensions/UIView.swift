//
//  UIView.swift
//  Test Leboncoin
//
//  Created by Sarah Del Castillo on 20/01/2024.
//

import UIKit

extension UIView {
    convenience init(forAutoLayout: Bool) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = !forAutoLayout
    }
}
