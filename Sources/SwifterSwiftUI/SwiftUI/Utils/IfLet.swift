//
//  IfLet.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

/// It is an utility that adds back a way to use the if let.
///
///    ifLet(myImage, then: {
///       $0.resizable()
///    })
///
/// - Parameters:
///   - value: optional value to verify
///   - then: callback to create a view with the value is not nil
/// - Returns: The built view
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@inlinable public func ifLet<T, ThenOut: View>(_ value: T?, then: (T) -> ThenOut) -> some View {
    ViewBuilder.buildIf(value.map { then($0) })
}

/// It is an utility that adds back a way to use the if let with an else option
///
///    ifLet(myImage, then: {
///       $0.resizable()
///    }, else: {
///       Text("Hello")
///    })
///
/// - Parameters:
///   - value: optional value to verify
///   - then: callback to create a view with the value is not nil
///   - else: callback to create a view with the value is nil
/// - Returns: The built view
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@inlinable public func ifLet<T, ThenOut: View, ElseOut: View>(
    _ value: T?,
    then: (T) -> ThenOut,
    `else`: () -> ElseOut) -> some View {
    value.map { ViewBuilder.buildEither(first: then($0)) } ??
        ViewBuilder.buildEither(second: `else`())
}

/// It is an utility that adds back a way to use the if let for collections checking if it is empty.
///
///    ifLet(myText, empty: false, then: {
///       Text($0)
///    })
///
/// - Parameters:
///   - value: optional value to verify
///   - empty: condition to check if string is valid when is empty.
///   - then: callback to create a view with the value is not nil
/// - Returns: The built view
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@inlinable public func ifLet<T, ThenOut: View>(
    _ value: T?,
    empty: Bool = false,
    then: (T) -> ThenOut
) -> some View where T : Collection {
    let value = !empty && value.isNilOrEmpty ? nil : value
    return ViewBuilder.buildIf(value.map { then($0) })
}

/// It is an utility that adds back a way to use the if let with an else option
///
///    ifLet(myText, empty: false, then: {
///       $0
///    }, else: {
///       Text("Hello")
///    })
///
/// - Parameters:
///   - value: optional value to verify
///   - empty: condition to check if string is valid when is empty.
///   - then: callback to create a view with the value is not nil
///   - else: callback to create a view with the value is nil
/// - Returns: The built view
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
@inlinable public func ifLet<T, ThenOut: View, ElseOut: View>(
    _ value: T?,
    empty: Bool = false,
    then: (T) -> ThenOut,
    `else`: () -> ElseOut
) -> some View where T : Collection {
    let value = !empty && value.isNilOrEmpty ? nil : value
    return value.map { ViewBuilder.buildEither(first: then($0)) } ??
        ViewBuilder.buildEither(second: `else`())
}
