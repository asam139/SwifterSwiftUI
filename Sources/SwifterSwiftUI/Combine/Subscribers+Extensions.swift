//
//  Subscribers+Extensions.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 02/05/2020.
//

import Foundation
import Combine

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Subscribers.Completion {
    /// Returns the optional failure value if it exists
    ///
    /// - Returns: Failure value
    @inlinable var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
