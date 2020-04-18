//
//  View+Animations.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

// MARK: General
extension View {

    /// SwifterSwiftUI: Type casting to AnyView
    ///
    ///    myView.eraseToAnyView()
    ///
    /// - Returns: View as AnyView
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

// MARK: Building
extension View {

    /// SwifterSwiftUI: Apply changes to the view if the condition is true
    ///
    ///    myView
    ///    .if(index == state.currentIndex, then: {
    ///        $0.background(Color.red)
    ///    })
    ///
    /// - Parameters:
    ///   - condition: an boolean to control the condition
    ///   - then: callback to apply the changes when the condition is true
    /// - Returns: some View
    public func `if`<Content: View>(_ conditional: Bool,
                                    then: (Self) -> Content) -> some View {
        if conditional {
            return then(self).eraseToAnyView()
        } else {
            return self.eraseToAnyView()
        }
    }

    /// SwifterSwiftUI: Apply some changes to the view in place of the condition
    ///
    ///    myView
    ///    .if(index == state.currentIndex, then: {
    ///        $0.background(Color.red)
    ///    }, else: {
    ///        $0.background(Color.yellow)
    ///    })
    ///
    /// - Parameters:
    ///   - condition: an boolean to control the condition
    ///   - then: callback to apply the changes when the condition is true
    ///   - else: callback to apply the changes when the condition is false
    /// - Returns: some View
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

    /// SwifterSwiftUI: Set one modifier conditionally.
    ///
    ///    myView.conditionalModifier(myCondition, myViewModifier)
    ///
    /// - Parameters:
    ///   - condition: an boolean to control the condition
    ///   - modifier: modifier to apply
    /// - Returns: some View
    public func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
        Group {
            if condition {
                self.modifier(modifier)
            } else {
                self
            }
        }
    }

    /// SwifterSwiftUI: Set one modifier or another conditionally.
    ///
    ///    myView.conditionalModifier(myCondition, firstViewModifier, secondViewModifier)
    ///
    /// - Parameters:
    ///   - condition: an boolean to control the condition
    ///   - trueModifier: modifier to apply when the condition is true
    ///   - falseModifier: modifier to apply when the condition is false
    /// - Returns: some View
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

    /// SwifterSwiftUI: Animate an action with an animation on appear.
    ///
    ///    myView.animate(using: .easeInOut) { self.scale = 0.5 }
    ///
    /// - Parameters:
    ///   - animation: animation to be applied
    ///   - action: action to be animated
    /// - Returns: some View
    public func animate(using animation: Animation = .easeInOut,
                        _ action: @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }

    /// SwifterSwiftUI: Animate an action with an inifinite animation on appear.
    ///
    ///    myView.animateForever(autoreverses: true) { self.scale = 0.5 }
    ///
    /// - Parameters:
    ///   - animation: animation to be applied
    ///   - autoreverses: it will do the initial animation but in reverse
    ///   - action: action to be animated
    /// - Returns: some View
    public func animateForever(using animation: Animation = .easeInOut,
                               autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}
