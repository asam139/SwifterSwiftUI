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


struct SubscribedView: View, Inspectable {
    @State var index: Int
    private let source: AnyPublisher<Int, Never>
    private let animation: Animation?

    let inspection = Inspection<Self>()

    init(
        source: AnyPublisher<Int, Never>,
        placeholder: Int,
        animation: Animation? = nil
    ) {
        self.source = source
        self.animation = animation
        self._index = State(initialValue:placeholder)
    }

    var body: some View {
        return Text("\(index)")
            .bind(source, to: $index.animation(animation))
            .onReceive(inspection.notice) { inspection.visit(self, $0) }
    }
}
