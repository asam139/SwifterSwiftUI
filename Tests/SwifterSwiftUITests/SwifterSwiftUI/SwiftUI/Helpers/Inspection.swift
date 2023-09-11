//
//  Inspection.swift
//  
//
//  Created by Saul Moreno Abril on 11/9/23.
//

import SwiftUI
import Combine
import ViewInspector

final class Inspection<V>: InspectionEmissary where V: View & Inspectable {
    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
