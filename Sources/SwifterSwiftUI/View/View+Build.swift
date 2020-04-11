//
//  View+Build.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

extension View {
    // If condition is met, apply modifier, otherwise, leave the view untouched
    public func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
        Group {
            if condition {
                self.modifier(modifier)
            } else {
                self
            }
        }
    }

    // Apply trueModifier if condition is met, or falseModifier if not.
    public func conditionalModifier<M1, M2>(
        _ condition: Bool, _ trueModifier: M1, _ falseModifier: M2
    ) -> some View where M1: ViewModifier, M2: ViewModifier {
        Group {
            if condition {
                self.modifier(trueModifier)
            } else {
                self.modifier(falseModifier)
            }
        }
    }
}

extension View {
    public func `if`<Content: View>(_ conditional: Bool,
                                    then: (Self) -> Content) -> some View {
        if conditional {
            return AnyView(then(self))
        } else {
            return AnyView(self)
        }
    }

    public func `if`<ThenView: View, ElseView: View>(
        _ conditional: Bool,
        then: (Self) -> ThenView,
        `else`: (Self) -> ElseView) -> some View {
        if conditional {
            return AnyView(then(self))
        } else {
            return AnyView(`else`(self))
        }
    }
}
