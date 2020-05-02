//
//  Publisher+Extensions.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 01/05/2020.
//

import Foundation
import Combine

extension Publisher {
    /// Attaches a subscriber with closure-based behavior returning a result.
    ///
    /// This method creates the subscriber and immediately requests an unlimited number of values, prior to returning the subscriber.
    /// - parameter result: The closure to execute on completion receiving a result.
    /// - Returns: A cancellable instance; used when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    public func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
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
}
