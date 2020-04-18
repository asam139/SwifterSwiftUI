//
//  IfLet.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

/// SwifterSwiftUI: it is an utility that adds back a way to use the if let.
///
///    ifLet(myImage, then: {
///       $0.resizable()
///    })
///
/// - Parameters:
///   - value: optional value to verify
///   - then: callback to create a view with the value is not nil
/// - Returns: The built view
public func ifLet<T, ThenOut: View>(_ value: T?, then: (T) -> ThenOut) -> some View {
    ViewBuilder.buildIf(value.map { then($0) })
}

/// SwifterSwiftUI: it is an utility that adds back a way to use the if let with an else option
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
/// - Returns: The built view
public func ifLet<T, ThenOut: View, ElseOut: View>(_ value: T?, then: (T) -> ThenOut, `else`: () -> ElseOut) -> some View {
    value.map { ViewBuilder.buildEither(first: then($0)) } ??
        ViewBuilder.buildEither(second: `else`())
}
