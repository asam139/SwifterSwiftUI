//
//  UserDefaultEnum.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 13/05/2020.
//

import XCTest
import SwiftUI
@testable import SwifterSwiftUI

final class UserDefaultEnumTests: XCTestCase {

    private struct User {
        @UserDefaultEnum(key: beverageKey, defaultValue: defaultValue) var beverage: Beverage
    }
    private var user: User!

    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: beverageKey)
        user = User()
    }

    func testInitWithKeyAndDefaultValue() {
        XCTAssertEqual(user.beverage, defaultValue)
    }

    func testWrappedValue() {
        let newBeverage: Beverage = .tea
        user.beverage = newBeverage
        XCTAssertEqual(user.beverage, newBeverage)

        // Force invalid enum for the key
        UserDefaults.standard.set("...", forKey: beverageKey)
        XCTAssertEqual(user.beverage, defaultValue)
    }
}

private let beverageKey = "beverageKey"
private let defaultValue = Beverage.coffee
private enum Beverage: String, CaseIterable {
    case coffee, tea, juice
}
