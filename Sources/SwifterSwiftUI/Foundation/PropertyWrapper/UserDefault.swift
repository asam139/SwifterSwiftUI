//
//  UserDefault.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 12/05/2020.
//

import Foundation

/// A type that adds an interface to use the user’s defaults with default types
///
/// Example:
/// ```
/// @UserDefault(key: "nameKey", defaultValue: "Root") var name: String
/// ```
/// Adding the attribute @UserDefault the property works reading and writing from user's defaults
///
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper public struct UserDefault<T> {
    private let key: String
    private let defaultValue: T

    /// Initialize the key and the default value.
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
