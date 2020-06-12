//
//  MutableTests.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 11/06/2020.
//

import XCTest
@testable import SwifterSwiftUI

final class MutableTests: XCTestCase {

    struct User: Mutable {
        var name: String

        func name(_ value: String) -> Self {
            mutating(keyPath: \.name, value: value)
        }
    }

    func testMutable() {
        let name0 = "User0"
        let name1 = "User1"
        let user = User(name: name0).name(name1)
        XCTAssertEqual(user.name, name1)
    }
}
