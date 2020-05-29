//
//  Result+Extensions.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 29/05/2020.
//

import XCTest
@testable import SwifterSwiftUI

enum TestingError: Error {
    case unknown
    case mapped
}

final class ResultExtensionsTests: XCTestCase {
    func testInitWithValueAndError() {
        let value = 1
        var error: TestingError?

        let sResult = Result(value: value, error: error)
        XCTAssertEqual(value, sResult.success)

        error = TestingError.unknown
        let eResult = Result(value: value, error: error)
        XCTAssertEqual(error, eResult.failure)
    }

    func testSuccessAndFailure() {
        let value = 1
        var error: TestingError?

        let sResult = Result(value: value, error: error)
        XCTAssertTrue(sResult.isSuccess)
        XCTAssertNotNil(sResult.success)
        XCTAssertNil(sResult.failure)

        error = TestingError.unknown
        let eResult = Result(value: value, error: error)
        XCTAssertTrue(eResult.isFailure)
        XCTAssertNil(eResult.success)
        XCTAssertNotNil(eResult.failure)
    }

    func testTryMap() {
        let value = 1
        var error: TestingError?

        let successedResult = Result(value: value, error: error)
        let mappedSuccessedResult = successedResult.tryMap { String($0) }
        XCTAssertEqual(mappedSuccessedResult.success, String(successedResult.success!))

        let failedMappedResult = successedResult.tryMap { _ in throw TestingError.unknown }
        XCTAssertTrue(failedMappedResult.isFailure)
        XCTAssertEqual(failedMappedResult.failure as! TestingError, TestingError.unknown)

        error = TestingError.unknown
        let failedResult = Result(value: value, error: error)
        let mappedFailedResult = failedResult.tryMap { String($0) }
        XCTAssertTrue(mappedFailedResult.isFailure)
    }

    func testTryMapError() {
        let value = 1
        var error: TestingError?

        let successedResult = Result(value: value, error: error)
        let mappedSuccessedResult = successedResult.tryMapError { _ in TestingError.mapped }
        XCTAssertTrue(mappedSuccessedResult.isSuccess)

        error = TestingError.unknown
        let failedResult = Result(value: value, error: error)
        let mappedFailedResult = failedResult.tryMapError { _ in TestingError.mapped }
        XCTAssertEqual(mappedFailedResult.failure as! TestingError, TestingError.mapped)

        let failedMappedResult = failedResult.tryMapError { _ -> TestingError in throw TestingError.unknown }
        XCTAssertTrue(failedMappedResult.isFailure)
        XCTAssertEqual(failedMappedResult.failure as! TestingError, TestingError.unknown)
    }
}
