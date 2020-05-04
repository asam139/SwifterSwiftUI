//
//  PublishedOnMainTests.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 04/05/2020.
//

import XCTest
import SwiftUI
@testable import SwifterSwiftUI

final class PublishedOnMainTests: XCTestCase {
    private struct ViewModel {
        @PublishedOnMain var name: String = "Anonymous"
    }
    private var viewModel: ViewModel!

    override func setUp() {
        super.setUp()
        viewModel = ViewModel()
    }

    func testSubscriptionOnMainThread() {
        let initialName = viewModel.name
        let subscription = viewModel.$name.sink { (name) in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertEqual(name, initialName)
        }
        subscription.cancel()
    }

    func testWrappedValue() {
        self.viewModel.name = "Root"
        let initialName = viewModel.name
        let subscription = viewModel.$name.sink { (name) in
            XCTAssertEqual(name, initialName)
        }
        subscription.cancel()
    }
}
