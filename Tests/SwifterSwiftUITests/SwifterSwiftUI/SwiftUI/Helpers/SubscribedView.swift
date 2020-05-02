//
//  SubscribedView.swift
//  SwifterSwiftUITests
//
//  Created by Saul Moreno Abril on 02/05/2020.
//

import SwiftUI
import Combine
import ViewInspector
@testable import SwifterSwiftUI

public struct SubscribedView: View, Inspectable {
    @State var index: Int
    private let source: AnyPublisher<Int, Never>
    private let animation: Animation?

    internal let inspection = Inspection<Self>()

    init(
        source: AnyPublisher<Int, Never>,
        placeholder: Int,
        animation: Animation? = nil
    ) {
        self.source = source
        self.animation = animation
        self._index = State(initialValue:placeholder)
    }

    public var body: some View {
        return Text("\(index)")
            .bind(source, to: $index.animation(animation))
            .onReceive(inspection.notice) { self.inspection.visit(self, $0) }
    }
}
