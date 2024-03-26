//
//  Binding+Extensions.swift
//  
//
//  Created by Saul Moreno Abril on 30/8/23.
//

import SwiftUI

public extension Binding {

    /// Create a binding animating the setter.
    ///
    ///     TabView(selection: $viewModel.selectedTabIndex.animated) {
    ///         Text("Home").tag(0)
    ///         Text("Settings").tag(1)
    ///     }
    ///
    /// - Returns: New binding
    var animated: Binding<Value> {
        Binding<Value>(
            get: { wrappedValue },
            set: { newValue in
                withAnimation {
                    wrappedValue = newValue
                }
            }
        )
    }
}
