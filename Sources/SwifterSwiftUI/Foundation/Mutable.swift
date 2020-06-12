//
//  Mutable.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 11/06/2020.
//

import Foundation

/// Adds a helper function to mutate a properties and help implement _Builder_ patter
/// Very useful to create methods to modify SwiftUI views
///
///     struct User: Mutable {
///         var name: String
///
///         func name(_ value: String) -> Self {
///             mutating(keyPath: \.name, value: value)
///         }
///     }
///
///     let user = User(name: "User0").name("User1"
///
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol Mutable { }

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Mutable {

    /// Mutates a property of the instance
    ///
    /// - Parameter keyPath:    `WritableKeyPath` to the instance property to be modified
    /// - Parameter value:      value to overwrite the  instance property
    @inlinable func mutating<T>(keyPath: WritableKeyPath<Self, T>, value: T) -> Self {
        var newSelf = self
        newSelf[keyPath: keyPath] = value
        return newSelf
    }
}
