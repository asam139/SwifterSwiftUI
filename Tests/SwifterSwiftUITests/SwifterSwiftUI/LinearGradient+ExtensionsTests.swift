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
        let gradient = LinearGradient(Color.red, Color.blue, startPoint: .topLeading, endPoint: .bottomTrailing)
        let inspGradient = try! gradient.inspect().linearGradient()
        XCTAssertTrue(try inspGradient.gradient().stops[0].color == Color.red)
        XCTAssertTrue(try inspGradient.gradient().stops[1].color == Color.blue)
        XCTAssertTrue(try inspGradient.startPoint() == .topLeading)
        XCTAssertTrue(try inspGradient.endPoint() == .bottomTrailing)
    }
}
