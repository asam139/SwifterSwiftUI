//
//  Result+Extensions.swift
//  Yuge
//
//  Created by Saul Moreno Abril on 26/05/2020.
//  Copyright © 2020 Yuge Technologies B.V. All rights reserved.
//

import Foundation

extension Result {
    /// Returns whether the instance is `.success`.
    public var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }

    /// Returns whether the instance is `.failure`.
    public var isFailure: Bool {
        !isSuccess
    }

    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var success: Success? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var failure: Failure? {
        guard case let .failure(error) = self else { return nil }
        return error
    }

    /// Initializes a `Result` from value or error. Returns `.failure` if the error is non-nil, `.success` otherwise.
    ///
    /// - Parameters:
    ///   - value: A value.
    ///   - error: An `Error`.
    public init(value: Success, error: Failure?) {
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
    public func tryMap<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, Error> {
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
    public func tryMapError<NewFailure: Error>(_ transform: (Failure) throws -> NewFailure) -> Result<Success, Error> {
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
