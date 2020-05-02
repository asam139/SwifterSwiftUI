//
//  View+Animations.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI
import Combine

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
    @available(iOS 13.0, OSX 10.15, tvOS 13.0, *)
    @available(watchOS, unavailable)
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
    public func `if`<Content: View>(
        _ conditional: Bool,
        then: (Self) -> Content
    ) -> TupleView<(Self?, Content?)> {
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
    public func `if`<A: View, B: View>(
        _ conditional: Bool,
        then: (Self) -> A,
        `else`: (Self) -> B
    ) -> TupleView<(A?, B?)> {
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
    public func conditionalModifier<M: ViewModifier>(
        _ condition: Bool,
        _ modifier: M
    ) -> TupleView<(Self?, ModifiedContent<Self, M>?)> {
        if condition {
            return TupleView((nil, self.modifier(modifier)))
        }
        return TupleView((self, nil))
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
    public func conditionalModifier<M: ViewModifier>(
        _ condition: Bool,
        _ trueModifier: M,
        _ falseModifier: M
    ) -> TupleView<(ModifiedContent<Self, M>?, ModifiedContent<Self, M>?)> {
        if condition {
            return TupleView((self.modifier(trueModifier), nil))
        }
        return TupleView((nil, self.modifier(falseModifier)))
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

// MARK: Combine

extension View {
    /// Bind publisher to state
    ///
    ///
    /// # Code
    /// Example to implement an async Image view
    /// ```
    /// struct AsyncImage: View {
    ///    @State private var image: UIImage
    ///    private let source: AnyPublisher<UIImage, Never>
    ///    private let animation: Animation?
    ///
    ///     init(
    ///         source: AnyPublisher<UIImage, Never>,
    ///         placeholder: UIImage,
    ///         animation: Animation? = nil
    ///     ) {
    ///         self.source = source
    ///         self.animation = animation
    ///         self._image = State(initialValue:placeholder)
    ///     }
    ///
    ///     var body: some View {
    ///        return Image(uiImage: image)
    ///             .resizable()
    ///             .bind(source, to: $image.animation(animation))
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - publisher: publisher to observe when a value is received
    ///   - state: state to assign the new value
    /// - Returns: some View
    func bind<P: Publisher, Value>(
        _ publisher: P,
        to state: Binding<Value>
    ) -> some View where P.Failure == Never, P.Output == Value {
        return onReceive(publisher) { value in
            state.wrappedValue = value
        }
    }
}
