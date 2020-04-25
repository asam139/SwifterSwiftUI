//
//  Color+ExtensionsTests.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 25/04/2020.
//

import XCTest
import SwiftUI
@testable import SwifterSwiftUI

final class ColorExtensionsTests: XCTestCase {
    func testInitWithHex() {
        XCTAssertNil(Color(hex: ""))
        XCTAssertNil(Color(hex: "---"))
        XCTAssertNil(Color(hex: "111"))
        XCTAssertNil(Color(hex: "#111"))
        XCTAssertNil(Color(hex: "#11111111111"))

        let colorValue: Double = 17.0 / 255
        let rgbHexString = "111111" // (17,17,17, 255)
        let rgbHexStringWithPrefix = "#" + rgbHexString
        let rgbaHexString = "11111111" // (17,17,17, 17)
        let rgbaHexStringWithPrefix = "#" + rgbaHexString

        let rgbColor = Color(red: colorValue, green: colorValue, blue: colorValue)
        let rgbaColor = Color(red: colorValue, green: colorValue, blue: colorValue, opacity: colorValue)

        // RGB
        let rgbHexColor = Color(hex: rgbHexString)
        XCTAssertNotNil(rgbHexColor)
        XCTAssertEqual(rgbHexColor, rgbColor)

        let rgbHexColorWithPrefix = Color(hex: rgbHexStringWithPrefix)
        XCTAssertNotNil(rgbHexColorWithPrefix)
        XCTAssertEqual(rgbHexColorWithPrefix, rgbColor)

        // RGBA
        let rgbaHexColor = Color(hex: rgbaHexString)
        XCTAssertNotNil(rgbaHexColor)
        XCTAssertEqual(rgbaHexColor, rgbaColor)

        let rgbaHexColorWithPrefix = Color(hex: rgbaHexStringWithPrefix)
        XCTAssertNotNil(rgbaHexColorWithPrefix)
        XCTAssertEqual(rgbaHexColorWithPrefix, rgbaColor)
    }
}
