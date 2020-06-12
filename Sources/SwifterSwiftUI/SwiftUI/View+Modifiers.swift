//
//  View+Modifiers.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 12/06/2020.
//

import SwiftUI

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {
    /// Tracks the size available for the view
    ///
    ///     myView.sizeTrackable($size)
    ///
    /// - Parameter size: This binding will receive the size updates
    @inlinable func sizeTrackable(_ size: Binding<CGSize>) -> some View {
        self.modifier(SizeViewModifier(size: size))
    }
}
