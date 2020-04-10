//
//  View+General.swift
//
//
//  Created by Saul Moreno Abril on 10/04/2020.
//

import SwiftUI

extension View {
    public func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
