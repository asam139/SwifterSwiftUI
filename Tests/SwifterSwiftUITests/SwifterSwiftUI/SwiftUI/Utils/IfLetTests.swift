//
//  IfLetTests.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 18/04/2020.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import SwifterSwiftUI

final class IfLetTests: XCTestCase {
    let testView = Text("Hello")

    func testIfLetThen() {
        var optionalString: String?

        // Test nil value
        let noView = ifLet(optionalString, then: { value in
            return Text(value)
        })
        XCTAssertThrowsError(try noView.inspect().text())

        // Test filled value
        optionalString = "hello"
        let view = ifLet(optionalString, then: { value in
            return Text(value)
        })
        XCTAssertNoThrow(try view.inspect().text())
    }

    func testIfLetThenElse() {
        var optionalString: String?

        // Test nil value
        let noView = ifLet(optionalString, then: { value in
            return Text(value)
        }, else: {
            return EmptyView()
        })
        XCTAssertNoThrow(try noView.inspect().emptyView())

        // Test filled value
        optionalString = "hello"
        let view = ifLet(optionalString, then: { value in
            return Text(value)
        }, else: {
            return EmptyView()
        })
        XCTAssertNoThrow(try view.inspect().text())
    }

    func testIfLetThenForCollections() {
        var optionalString: String?

        // Test nil value
        var view = ifLet(optionalString, empty: false, then: { value in
            return Text(value)
        })
        XCTAssertThrowsError(try view.inspect().text())

        // Test empty value
        optionalString = ""
        view = ifLet(optionalString, empty: false, then: { value in
            return Text(value)
        })
        XCTAssertThrowsError(try view.inspect().text())
        view = ifLet(optionalString, empty: true, then: { value in
            return Text(value)
        })
        XCTAssertNoThrow(try view.inspect().text())

        // Test filled value
        optionalString = "hello"
        view = ifLet(optionalString, then: { value in
            return Text(value)
        })
        XCTAssertNoThrow(try view.inspect().text())
    }

    func testIfLetThenElseForCollections() {
        var optionalString: String?

        // Test nil value
        var view = ifLet(optionalString, empty: false, then: { value in
            return Text(value)
        }, else: {
            return EmptyView()
        })
        XCTAssertNoThrow(try view.inspect().emptyView())

        // Test empty value
        optionalString = ""
        view = ifLet(optionalString, empty: false, then: { value in
            return Text(value)
        }, else: {
            return EmptyView()
        })
        XCTAssertNoThrow(try view.inspect().emptyView())
        view = ifLet(optionalString, empty: true, then: { value in
            return Text(value)
        }, else: {
            return EmptyView()
        })
        XCTAssertNoThrow(try view.inspect().text())

        // Test filled value
        optionalString = "hello"
        view = ifLet(optionalString, then: { value in
            return Text(value)
        }, else: {
            return EmptyView()
        })
        XCTAssertNoThrow(try view.inspect().text())
    }
}
