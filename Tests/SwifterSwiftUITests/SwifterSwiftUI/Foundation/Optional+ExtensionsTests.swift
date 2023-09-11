//
//  Optional+ExtensionsTests.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 09/06/2020.
//

import XCTest
import SwiftUI
@testable import SwifterSwiftUI

final class OptionalTests: XCTestCase {
    func testIsNilOrEmpty() {
        var string: String?
        XCTAssertTrue(string.isNilOrEmpty)
        string = ""
        XCTAssertTrue(string.isNilOrEmpty)
        string = "_"
        XCTAssertFalse(string.isNilOrEmpty)
    }
}
