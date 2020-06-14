//
//  Result+Extensions.swift
//  Yuge
//
//  Created by Saul Moreno Abril on 26/05/2020.
//  Copyright © 2020 Yuge Technologies B.V. All rights reserved.
//

import Foundation

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Result {
    /// Returns whether the instance is `.success`.
    @inlinable var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }

    /// Returns whether the instance is `.failure`.
    @inlinable var isFailure: Bool {
        !isSuccess
    }

    /// Returns the associated value if the result is a success, `nil` otherwise.
    @inlinable var success: Success? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    @inlinable var failure: Failure? {
        guard case let .failure(error) = self else { return nil }
        return error
    }

    /// Initializes a `Result` from value or error. Returns `.failure` if the error is non-nil, `.success` otherwise.
    ///
    /// - Parameters:
    ///   - value: A value.
    ///   - error: An `Error`.
    @inlinable init(value: Success, error: Failure?) {
        if let error = error {
            self = .failure(error)
        } else {
            self = .success(value)
        }
    }

    /// Evaluates the specified closure when the `Result` is a success, passing the unwrapped value as a parameter.
    ///
    /// Use the `tryMap` method with a closure that may throw an error. For example:
    ///
    ///     let possibleData: Result<Data, Error> = .success(Data(...))
    ///     let possibleObject = possibleData.tryMap {
    ///         try JSONSerialization.jsonObject(with: $0)
    ///     }
    ///
    /// - parameter transform: A closure that takes the success value of the instance.
    ///
    /// - returns: A `Result` containing the result of the given closure. If this instance is a failure, returns the
    ///            same failure.
    @inlinable func tryMap<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, Error> {
        switch self {
        case let .success(value):
            do {
                return try .success(transform(value))
            } catch {
                return .failure(error)
            }
        case let .failure(error):
            return .failure(error)
        }
    }

    /// Evaluates the specified closure when the `Result` is a failure, passing the unwrapped error as a parameter.
    ///
    /// Use the `tryMapError` function with a closure that may throw an error. For example:
    ///
    ///     let possibleData: Result<Data, Error> = .success(Data(...))
    ///     let possibleObject = possibleData.tryMapError {
    ///         try someFailableFunction(taking: $0)
    ///     }
    ///
    /// - Parameter transform: A throwing closure that takes the error of the instance.
    ///
    /// - Returns: A `Result` instance containing the result of the transform. If this instance is a success, returns
    ///            the same success.
    @inlinable func tryMapError<NewFailure: Error>(
        _ transform: (Failure) throws -> NewFailure
    ) -> Result<Success, Error> {
        switch self {
        case let .failure(error):
            do {
                return try .failure(transform(error))
            } catch {
                return .failure(error)
            }
        case let .success(value):
            return .success(value)
        }
    }
}
