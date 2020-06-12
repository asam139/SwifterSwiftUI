//
//  SizeViewModifier.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 12/06/2020.
//

import SwiftUI

/// This modifier wraps a view into a `GeometryReader` and tracks the available space.
///
///     @State var size: CGSize = .zero
///
///     myView.modifier(SizeViewModifier(size: $size))
///
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct SizeViewModifier: ViewModifier {
    @Binding private(set) var size: CGSize

    /// Create a size view modifier from a CGSize binding
    ///
    ///     myView.modifier(SizeViewModifier(size: $size))
    ///
    /// - Parameters:
    ///   - size: CGSize binding
    /// - Returns: A new modifier
    public init(size: Binding<CGSize>) {
        self._size = size
    }

    public func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .frame(size: proxy.size)
                .onReload(perform: {
                    self.size = proxy.size
                })
        }
    }
}
