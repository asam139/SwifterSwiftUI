//
//  LinearGradient+ExtensionsTests.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 22/04/2020.
//
import XCTest
import SwiftUI
@testable import SwifterSwiftUI

final class LinearGradientExtensionsTests: XCTestCase {
    func testInitWithColors() {
        let firstColor = Color.red
        let secondColor = Color.blue
        let gradient = LinearGradient(firstColor, secondColor, startPoint: .topLeading, endPoint: .bottomTrailing)
        XCTAssertNoThrow({
            let inspGradient = try gradient.inspect().linearGradient()
            XCTAssertTrue(try inspGradient.gradient().stops[0].color == firstColor)
            XCTAssertTrue(try inspGradient.gradient().stops[1].color == secondColor)
            XCTAssertTrue(try inspGradient.startPoint() == .topLeading)
            XCTAssertTrue(try inspGradient.endPoint() == .bottomTrailing)
        })
    }
}
