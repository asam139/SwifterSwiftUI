//
//  Subscribers+Extensions.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 02/05/2020.
//

import Foundation
import Combine

extension Subscribers.Completion {
    /// Returns the optional failure value if it exists
    ///
    /// - Returns: Failure value
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
