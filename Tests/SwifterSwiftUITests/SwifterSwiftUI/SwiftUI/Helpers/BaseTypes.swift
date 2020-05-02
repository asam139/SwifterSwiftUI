//
//  BaseTypes.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 02/05/2020.
//

import Foundation
import SwiftUI
import Combine
import ViewInspector

struct InspectableTestModifier: ViewModifier {
    var onAppear: ((Self.Body) -> Void)?

    func body(content: Self.Content) -> some View {
        content
            .onAppear { self.onAppear?(self.body(content: content)) }
    }
}

enum TestError: Error {
    case test
}

// MARK: Inspection Helper
internal final class Inspection<V> where V: View {

    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}

extension Inspection: InspectionEmissary where V: Inspectable { }
