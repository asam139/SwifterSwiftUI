//
//  Optional+Extensions.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 08/06/2020.
//

import Foundation

extension Optional where Wrapped: Collection {
    /// Returns whether the instance is nil or empty.
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
