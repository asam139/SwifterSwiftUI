//
//  IfLet.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

public func ifLet<T, ThenOut: View>(_ value: T?, then: (T) -> ThenOut) -> some View {
    ViewBuilder.buildIf(value.map { then($0) })
}

public func ifLet<T, ThenOut: View, ElseOut: View>(_ value: T?, then: (T) -> ThenOut, `else`: () -> ElseOut) -> some View {
    value.map { ViewBuilder.buildEither(first: then($0)) } ?? ViewBuilder.buildEither(second: `else`())
}
