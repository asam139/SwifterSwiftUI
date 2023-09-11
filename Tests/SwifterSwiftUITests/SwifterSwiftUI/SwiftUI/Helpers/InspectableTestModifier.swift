//
//  InspectableTestModifier.swift
//  
//
//  Created by Saul Moreno Abril on 11/9/23.
//

import SwiftUI

struct InspectableTestModifier: ViewModifier {
    var onAppear: ((Self) -> Void)?

    func body(content: Self.Content) -> some View {
        content.onAppear { onAppear?(self) }
    }
}
