//
//  UserDefaultEnum.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 12/05/2020.
//

import Foundation

/// A type that adds an interface to use the user’s defaults with raw representable types where the raw value is of type string
///
/// Example:
/// ```
/// enum Beverage: String, CaseIterable {
///     case coffee, tea, juice
/// }
///
/// @UserDefaultEnum(key: "beverageKey", defaultValue: .coffee) var beverage: Beverage
/// ```
/// Adding the attribute @UserDefaultEnum the property works reading and writing from user's defaults
///
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@propertyWrapper public struct UserDefaultEnum<T: RawRepresentable> where T.RawValue == String {
    private let key: String
    private let defaultValue: T

    /// Initialize the key and the default value.
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            if let string = UserDefaults.standard.string(forKey: key) {
                return T(rawValue: string) ?? defaultValue
            }
            return defaultValue
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
        }
    }
}
