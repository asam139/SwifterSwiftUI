//
//  View+Animations.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

// MARK: General
extension View {
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

// MARK: Building
extension View {
    public func `if`<Content: View>(_ conditional: Bool,
                                    then: (Self) -> Content) -> some View {
        if conditional {
            return then(self).eraseToAnyView()
        } else {
            return self.eraseToAnyView()
        }
    }

    public func `if`<ThenView: View, ElseView: View>(
        _ conditional: Bool,
        then: (Self) -> ThenView,
        `else`: (Self) -> ElseView) -> some View {
        if conditional {
            return then(self).eraseToAnyView()
        } else {
            return `else`(self).eraseToAnyView()
        }
    }
}

// MARK: Modifiers
extension View {
    public func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
        Group {
            if condition {
                self.modifier(modifier)
            } else {
                self
            }
        }
    }

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

// MARK: Animations
extension View {
    public func animate(using animation: Animation = Animation.easeInOut(duration: 1),
                        _ action: @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }

    public func animateForever(using animation: Animation = Animation.easeInOut(duration: 1),
                               autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}
