//
//  Publisher+ExtensionsTests.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 01/05/2020.
//

import XCTest
import Combine
@testable import SwifterSwiftUI

final class PublisherExtensionsTests: XCTestCase {
    func testSinkReceiveCompletion() {
        let value: String = "Hello"
        let subject = PassthroughSubject<String, TestError>()
        let subscription = subject.sink { (completion) in
            XCTAssertEqual(completion, Subscribers.Completion.finished)
        }
        subject.send(value)
        subject.send(completion: .finished)
        subscription.cancel()
    }

    func testSinkToResult() {
        // Success
        let value: String = "Hello"
        let successExp = XCTestExpectation()
        let successSubject = PassthroughSubject<String, TestError>()
        let successSubscription = successSubject.sinkToResult { (result) in
            switch (result) {
            case .success(let text):
                if text == value {
                    successExp.fulfill()
                }
            default: break
            }
        }

        successSubject.send(value)
        successSubject.send(completion: Subscribers.Completion<TestError>.finished)
        wait(for: [successExp], timeout: 0.1)
        successSubscription.cancel()

        // Failure
        let errorValue = TestError.test
        let failureExp = XCTestExpectation()
        let failureSubject = PassthroughSubject<String, TestError>()
        let failureSubscription = failureSubject.sinkToResult { (result) in
            switch (result) {
            case .failure(let error):
                if error == errorValue {
                    failureExp.fulfill()
                }
            default: break
            }
        }
        failureSubject.send(completion: Subscribers.Completion<TestError>.failure(errorValue))
        wait(for: [failureExp], timeout: 0.1)
        failureSubscription.cancel()
    }

    func testReplaceError() {
        let defaultValue: String = "Hello"
        let subject = PassthroughSubject<String, TestError>()
        let subscription = subject.replaceError({ _ in
            return defaultValue
        }).sink { (value) in
            XCTAssertEqual(value, defaultValue)
        }
        subject.send(completion: .failure(.test))
        subscription.cancel()
    }

    func testIgnoreError() {
        let subject = PassthroughSubject<String, TestError>()
        let subscription = subject.ignoreError().sink(receiveCompletion: { (completion) in
            XCTAssertEqual(completion, Subscribers.Completion.finished)
        }) { (_) in }
        subject.send(completion: .failure(.test))
        subscription.cancel()
    }
}
