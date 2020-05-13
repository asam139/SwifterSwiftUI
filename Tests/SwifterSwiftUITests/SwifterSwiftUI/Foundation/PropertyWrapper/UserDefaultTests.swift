//
//  UserDefaultTests.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 12/05/2020.
//

import XCTest
import SwiftUI
@testable import SwifterSwiftUI

private let nameKey = "nameKey"
private let defaultName = "Root"

final class UserDefaultTests: XCTestCase {
    private struct User {
        @UserDefault(key: nameKey, defaultValue: defaultName) var name: String
    }
    private var user: User!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: nameKey)
        user = User()
    }

    func testInitWithKeyAndDefaultValue() {
        XCTAssertEqual(user.name, defaultName)
    }

    func testWrappedValue() {
        let newName = "Admin"
        user.name = newName
        XCTAssertEqual(user.name, newName)
    }
}
