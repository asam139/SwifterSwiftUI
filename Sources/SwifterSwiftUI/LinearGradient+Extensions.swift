//
//  LinearGradient.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 22/04/2020.
//

import SwiftUI

extension LinearGradient {

    /// Create a gradient directly from colors
    ///
    ///    let myGradient = LinearGradient(Color.red, Color.blue)
    ///
    /// - Parameters:
    ///   - colors: array of colors
    ///   - startPoint: unit point where gradient starts
    ///   - endPoint: unit point where gradient starts
    /// - Returns: A new linear gradient
    init(_ colors: Color...,
        startPoint: UnitPoint = .topLeading,
        endPoint: UnitPoint = .bottomTrailing) {
        self.init(gradient: Gradient(colors: colors),
                  startPoint: startPoint,
                  endPoint: endPoint)
    }
}
