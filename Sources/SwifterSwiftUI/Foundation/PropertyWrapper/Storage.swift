//
//  Storage.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 03/05/2020.
//

import Foundation

/// A type that adds an interface to use the user’s defaults.
///
/// Example:
/// ```
/// @Storage(key: "nameKey", defaultValue: "Root") var name: String?
/// ```
/// Adding the attribute @Storage the property works reading and writing from user's defaults.
///
@propertyWrapper public struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T

    /// Initialize the key and the default value.
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)

            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
