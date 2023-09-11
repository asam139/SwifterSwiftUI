//
//  SizeTrackableView.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 12/06/2020.
//

import SwiftUI
import Combine
import ViewInspector
@testable import SwifterSwiftUI

struct SizeTrackableView: View, Inspectable {
    @State var size: CGSize = .zero

    let inspection = Inspection<Self>()

    var body: some View {
        Text("Hello")
            .sizeTrackable($size)
            .onReceive(inspection.notice) { inspection.visit(self, $0) }
    }
}

struct SizeTrackableView_Previews: PreviewProvider {
    static var previews: some View {
        SizeTrackableView()
    }
}
