//
//  Optional+Extensions.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 08/06/2020.
//

import Foundation

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Optional where Wrapped: Collection {
    /// Returns whether the instance is nil or empty.
    @inlinable var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
