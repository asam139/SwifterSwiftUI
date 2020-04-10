//
//  IfLet.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 09/04/2020.
//  Copyright © 2020 Saul Moreno Abril. All rights reserved.
//

import SwiftUI

func ifLet<T, ThenOut: View>(_ value: T?, then: (T) -> ThenOut) -> some View {
    ViewBuilder.buildIf(value.map { then($0) })
}

func ifLet<T, ThenOut: View, ElseOut: View>(_ value: T?, then: (T) -> ThenOut, `else`: () -> ElseOut) -> some View {
    value.map { ViewBuilder.buildEither(first: then($0)) } ?? ViewBuilder.buildEither(second: `else`())
}
