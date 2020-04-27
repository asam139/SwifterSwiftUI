//
//  Image+ExtensionsTests.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 26/04/2020.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import SwifterSwiftUI

final class ImageExtensionsTests: XCTestCase {
    func testInitWithNameAndDefaultImage() {

        let defaultImage = Image("no-example", defaultImage: "empty-photo")
        XCTAssertNoThrow(try defaultImage.inspect().image())

        let image = Image("example", defaultImage: "empty-photo")
        XCTAssertNoThrow(try image.inspect().image())
    }

    #if canImport(UIKit)
    func testInitWithNameAndDefaultSystemImage() {
        let image = Image("photo", defaultSystemImage: "bandage.fill")
        XCTAssertNoThrow(try image.inspect().image())
    }
    #endif
}
