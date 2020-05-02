//
//  Subscribers+ExtensionsTests.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 02/05/2020.
//

import XCTest
import Combine
@testable import SwifterSwiftUI

final class SubscribersExtensionsTests: XCTestCase {
    func testCompletionError() {
        let finishedCompletion = Subscribers.Completion<TestError>.finished
        XCTAssertNil(finishedCompletion.error)

        let failureCompletion = Subscribers.Completion<TestError>.failure(.test)
        XCTAssertEqual(failureCompletion.error, TestError.test)
    }
}
