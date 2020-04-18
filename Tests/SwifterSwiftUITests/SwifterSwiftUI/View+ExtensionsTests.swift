import XCTest
import SwiftUI
import ViewInspector
@testable import SwifterSwiftUI

final class ViewExtensionsTests: XCTestCase {
    let text = Text("Hello")

    // MARK: General
    func testEraseToAnyView() {
        let anyView = text.eraseToAnyView()
        XCTAssertNoThrow(try anyView.inspect().anyView().text())
    }

    // MARK: Building
    func testIfThen() {
        let textWithZIndex = text.if(true, then: { $0.zIndex(13) })
        textWithZIndex.inspect { (view) in
            XCTAssertNoThrow(try view.anyView().text().zIndex())
        }

        let textWithoutZIndex = text.if(false, then: { $0.zIndex(13) })
        textWithoutZIndex.inspect { (view) in
            XCTAssertThrowsError(try view.anyView().text().zIndex())
        }
    }

    func testIfThenElse() {
        let firstIndex = 9.0, secondIndex = 13.0
        let firstText = text.if(true, then: { $0.zIndex(firstIndex) }, else: { $0.zIndex(secondIndex)})
        firstText.inspect { (view) in
            XCTAssertEqual(try view.anyView().text().zIndex(), firstIndex)
        }

        let secondText = text.if(false, then: { $0.zIndex(firstIndex) }, else: { $0.zIndex(secondIndex)})
        secondText.inspect { (view) in
            XCTAssertEqual(try view.anyView().text().zIndex(), secondIndex)
        }
    }

    static var allTests = [
        ("testEraseToAnyView", testEraseToAnyView),
        ("testIfThen", testIfThen),
        ("testIfThenElse", testIfThenElse)
    ]
}
