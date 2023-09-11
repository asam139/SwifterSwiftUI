//
//  View+ModifiersTests.swift
//  SwifterSwiftUI
//
//  Created by Saul Moreno Abril on 12/06/2020.
//

import XCTest
import SwiftUI
import Combine
import ViewInspector
@testable import SwifterSwiftUI

final class ViewModifiersTests: XCTestCase {
    // MARK: General
    func testSizeTrackable() {
        let sut = SizeTrackableView()
        let exp = sut.inspection.inspect(after: 0.1) { (view) in
            XCTAssertNotEqual(try view.actualView().size, CGSize.zero)
        }
        ViewHosting.host(view: sut)
        wait(for: [exp], timeout: 0.1)
    }
}
