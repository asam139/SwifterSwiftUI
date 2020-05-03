//
//  StorageTests.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 03/05/2020.
//

import XCTest
import SwiftUI
@testable import SwifterSwiftUI

private let nameKey = "nameKey"
private let defaultName = "Root"

final class StorageTests: XCTestCase {
    private struct User {
        @Storage(key: nameKey, defaultValue: defaultName) var name: String?
    }
    private var user: User!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: defaultName)
        user = User()
    }

    func testInitWithKeyAndDefaultValue() {
        XCTAssertEqual(user.name, defaultName)
    }

    func testWrappedValue() {
        let newName = "Admin"
        user.name = newName
        XCTAssertEqual(user.name, newName)

        // Force invalid object for the key
        let arrayData = try? JSONEncoder().encode([String]())
        UserDefaults.standard.set(arrayData, forKey: nameKey)
        XCTAssertEqual(user.name, defaultName)
    }
}
