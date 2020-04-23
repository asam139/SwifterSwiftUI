import XCTest
import SwiftUI
import ViewInspector
@testable import SwifterSwiftUI

final class ViewExtensionsTests: XCTestCase {
    // MARK: General
    func testEraseToAnyView() {
        let anyView = EmptyView().eraseToAnyView()
        XCTAssertNoThrow(try anyView.inspect().anyView().emptyView())
    }

    func testEmbedInNavigation() {
        let anyView = EmptyView().embedInNavigation()
        XCTAssertNoThrow(try anyView.inspect().navigationView())
    }

    // MARK: Building
    func testIfThen() {
        let withZIndex = EmptyView().if(true, then: { $0.zIndex(13) })
        withZIndex.inspect { (view) in
            XCTAssertNoThrow(try view.anyView().emptyView().zIndex())
        }

        let withoutZIndex = EmptyView().if(false, then: { $0.zIndex(13) })
        withoutZIndex.inspect { (view) in
            XCTAssertThrowsError(try view.anyView().emptyView().zIndex())
        }
    }

    func testIfThenElse() {
        let firstIndex = 9.0, secondIndex = 13.0
        let firstView = EmptyView().if(true, then: { $0.zIndex(firstIndex) }, else: { $0.zIndex(secondIndex)})
        firstView.inspect { (view) in
            XCTAssertEqual(try view.anyView().emptyView().zIndex(), firstIndex)
        }

        let secondView = EmptyView().if(false, then: { $0.zIndex(firstIndex) }, else: { $0.zIndex(secondIndex)})
        secondView.inspect { (view) in
            XCTAssertEqual(try view.anyView().emptyView().zIndex(), secondIndex)
        }
    }

    // MARK: Modifiers
    func testConditionalModifier() {
        let testView = Text("Hello")
        var modifier = InspectableTestModifier()

        // Test true condition
        let firstExp = XCTestExpectation()
        modifier.onAppear = { body in
            ViewHosting.expel()
            firstExp.fulfill()
        }
        let view = testView.conditionalModifier(true, modifier)
        ViewHosting.host(view: view)
        wait(for: [firstExp], timeout: 0.1)

        // Test false condition
        let secondExp = XCTestExpectation(description: #function)
        secondExp.isInverted = true
        modifier.onAppear = { body in
            ViewHosting.expel()
            secondExp.fulfill()
        }
        let secondView = testView.conditionalModifier(false, modifier)
        ViewHosting.host(view: secondView)
        wait(for: [secondExp], timeout: 0.1)
    }

    func testConditionalModifierOr() {
        let testView = Text("Hello")
        var thenModifier = InspectableTestModifier()
        var elseModifier = InspectableTestModifier()

        // Test true condition
        let firstExp = XCTestExpectation(description: #function)
        thenModifier.onAppear = { body in
            ViewHosting.expel()
            firstExp.fulfill()
        }
        let firstView = testView.conditionalModifier(true, thenModifier, elseModifier)
        ViewHosting.host(view: firstView)
        wait(for: [firstExp], timeout: 0.1)

        // Test false condition
        let secondExp = XCTestExpectation(description: #function)
        thenModifier.onAppear = nil
        elseModifier.onAppear = { body in
            ViewHosting.expel()
            secondExp.fulfill()
        }
        let secondView = testView.conditionalModifier(false, thenModifier, elseModifier)
        ViewHosting.host(view: secondView)
        wait(for: [secondExp], timeout: 0.1)
    }

    // MARK: Animations
    func testAnimateOnAppear() {
        let testView = Text("Hello")

        let exp = XCTestExpectation(description: #function)
        let view = testView.animateOnAppear {
            ViewHosting.expel()
            exp.fulfill()
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 0.1)

        // Check onAppear modifier
        XCTAssertNoThrow(try view.inspect().callOnAppear())
    }

    func testAnimateOnDisappear() {
        let testView = Text("Hello")

        let exp = XCTestExpectation(description: #function)
        let view = testView.onAppear {
            ViewHosting.expel()
        }.animateOnDisappear {
            exp.fulfill()
        }
        ViewHosting.host(view: view)
        // Check onAppear modifier
        // OnDisappear does not work in macOS
        // so it's called manually before the checking
        XCTAssertNoThrow(try view.inspect().callOnDisappear())
        wait(for: [exp], timeout: 0.1)
    }

    static var allTests = [
        ("testEraseToAnyView", testEraseToAnyView),
        ("testIfThen", testIfThen),
        ("testIfThenElse", testIfThenElse),
        ("testConditionalModifier", testConditionalModifier),
        ("testConditionalModifierOr", testConditionalModifierOr),
        ("testAnimateOnAppear", testAnimateOnAppear),
        ("testAnimateOnDisappear", testAnimateOnDisappear)
    ]
}

private struct TestModifier: ViewModifier {
    func body(content: Self.Content) -> some View {
        content.onAppear()
    }
}

private struct InspectableTestModifier: ViewModifier {
    var onAppear: ((Self.Body) -> Void)?

    func body(content: Self.Content) -> some View {
        content
            .onAppear { self.onAppear?(self.body(content: content)) }
    }
}
