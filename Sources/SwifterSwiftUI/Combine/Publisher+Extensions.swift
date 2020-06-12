//
//  Publisher+Extensions.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 01/05/2020.
//

import Foundation
import Combine

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Publisher {
    /// Attaches a subscriber with closure-based behavior only for the completion
    ///
    /// Example:
    /// ```
    /// let subscription = subject.sink { (completion) in
    ///    XCTAssertEqual(completion, Subscribers.Completion.finished)
    /// }
    /// ```
    /// - parameter receiveCompletion: The closure for completion.
    /// - Returns: A subscriber that performs the provided closure upon receiving completion.
    @inlinable func sink(
        receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void)
    ) -> AnyCancellable {
        return sink(receiveCompletion: receiveCompletion, receiveValue: { _ in })
    }

    /// Attaches a subscriber with closure-based behavior returning a result.
    ///
    /// Example:
    /// ```
    /// let successSubscription = successSubject.sinkToResult { (result) in
    ///    switch (result) {
    ///    case .success(let text):
    ///        print(text)
    ///    default: break
    ///    }
    /// }
    /// ```
    /// - parameter result: The closure to execute on completion receiving a result.
    /// - Returns: A subscriber that performs the provided closure upon receiving values or completion returning a result.
    @inlinable func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }

    /// Handles errors from an upstream publisher by replacing it with another publisher without errors.
    ///
    /// The following example shows as using it.
    /// ```
    /// subject.replaceError({ error in
    ///    return error.localizedDescription
    /// })
    /// ```
    ///
    /// - parameter replace: The closure to replace the error.
    /// - Returns: A new publisher without error.
    @inlinable func replaceError(
        _ replace: @escaping (Failure) -> Self.Output
    ) -> Publishers.Catch<Self, Just<Self.Output>> {
        return `catch` { error in
            Just(replace(error))
        }
    }

    /// Handles errors from an upstream publisher ignoring them.
    ///
    /// The following example shows as using it.
    ///
    /// - Returns: A new publisher which ignores any error.
    @inlinable func ignoreError() -> Publishers.Catch<Self, Empty<Self.Output, Self.Failure>> {
        return `catch` { _ in
            Empty()
        }
    }
}
