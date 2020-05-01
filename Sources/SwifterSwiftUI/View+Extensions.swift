//
//  View+Animations.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

extension View {

    /// Type casting to AnyView
    ///
    ///    myView.eraseToAnyView()
    ///
    /// - Returns: View as AnyView
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

    /// Encapsulate view in navigation view
    ///
    ///    myView.embedInNavigation()
    ///
    /// - Returns: view encapsulate in navigation view
    func embedInNavigation() -> some View {
        NavigationView { self }
    }
}

// MARK: Building
extension View {

    /// Apply changes to the view if the condition is true
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
                                    then: (Self) -> Content) -> TupleView<(Self?, Content?)> {
        if conditional {
            return TupleView((nil, then(self)))
        }
        return TupleView((self, nil))
    }

    /// Apply some changes to the view in place of the condition
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
    public func `if`<A: View, B: View>(_ conditional: Bool,
                                       then: (Self) -> A,
                                       `else`: (Self) -> B) -> TupleView<(A?, B?)> {
        if conditional {
            return TupleView((then(self), nil))
        }
        return TupleView((nil, `else`(self)))
    }
}

// MARK: Modifiers
extension View {

    /// Set one modifier conditionally.
    ///
    ///    myView.conditionalModifier(myCondition, myViewModifier)
    ///
    /// - Parameters:
    ///   - condition: an boolean to control the condition
    ///   - modifier: modifier to apply
    /// - Returns: some View
    public func conditionalModifier<M>(_ condition: Bool, _ modifier: M) -> some View where M: ViewModifier {
        Group {
            if condition {
                self.modifier(modifier).eraseToAnyView()
            } else {
                self
            }
        }
    }

    /// Set one modifier or another conditionally.
    ///
    ///    myView.conditionalModifier(myCondition, firstViewModifier, secondViewModifier)
    ///
    /// - Parameters:
    ///   - condition: an boolean to control the condition
    ///   - trueModifier: modifier to apply when the condition is true
    ///   - falseModifier: modifier to apply when the condition is false
    /// - Returns: some View
    public func conditionalModifier<M>(
        _ condition: Bool, _ trueModifier: M, _ falseModifier: M) -> some View where M: ViewModifier {
        Group {
            if condition {
                self.modifier(trueModifier).eraseToAnyView()
            } else {
                self.modifier(falseModifier).eraseToAnyView()
            }
        }
    }
}

// MARK: Animations
extension View {

    /// Animate an action with an animation on appear.
    ///
    ///    myView.animateOnAppear(using: .easeInOut) { self.scale = 0.5 }
    ///
    /// - Parameters:
    ///   - animation: animation to be applied
    ///   - action: action to be animated
    /// - Returns: some View
    public func animateOnAppear(using animation: Animation = .easeInOut,
                                _ action: @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }

    /// Animate an action with an animation on disappear.
    ///
    ///    myView.animateOnDisappear(using: .easeInOut) { self.scale = 0.5 }
    ///
    /// - Parameters:
    ///   - animation: animation to be applied
    ///   - action: action to be animated
    /// - Returns: some View
    public func animateOnDisappear(using animation: Animation = .easeInOut,
                                   _ action: @escaping () -> Void) -> some View {
        return onDisappear {
            withAnimation(animation) {
                action()
            }
        }
    }
}
