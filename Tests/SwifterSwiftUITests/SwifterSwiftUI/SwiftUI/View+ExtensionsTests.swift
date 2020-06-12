import XCTest
import SwiftUI
import Combine
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

    func testFrameWithSize() {
        let text = Text("").frame(size: CGSize(width: 100, height: 100))
        XCTAssertNoThrow({
            let fixedFrame = try text.inspect().text().fixedFrame()
            XCTAssertEqual(fixedFrame.width, 100)
            XCTAssertEqual(fixedFrame.height, 100)
        })
    }

    func testOnReload() {
        let expectation = XCTestExpectation()
        _ = Text("").onReload {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}

// MARK: Building
extension ViewExtensionsTests {
    func testIfThen() {
        let zIndex: Double = 13

        let withZIndex = EmptyView().if(true, then: { $0.zIndex(zIndex) })
        XCTAssertNil(withZIndex.value.0)
        XCTAssertNotNil(withZIndex.value.1)
        XCTAssertEqual(try withZIndex.value.1!.inspect().emptyView().zIndex(), zIndex)

        let withoutZIndex = EmptyView().if(false, then: { $0.zIndex(zIndex) })
        XCTAssertNotNil(withoutZIndex.value.0)
        XCTAssertThrowsError(try withoutZIndex.value.0.inspect().emptyView().zIndex())
        XCTAssertNil(withoutZIndex.value.1)
    }

    func testIfThenElse() {
        let firstIndex = 9.0, secondIndex = 13.0
        let firstView = EmptyView().if(true, then: { $0.zIndex(firstIndex) }, else: { $0.zIndex(secondIndex)})
        XCTAssertNotNil(firstView.value.0)
        XCTAssertEqual(try firstView.value.0.inspect().emptyView().zIndex(), firstIndex)
        XCTAssertNil(firstView.value.1)

        let secondView = EmptyView().if(false, then: { $0.zIndex(firstIndex) }, else: { $0.zIndex(secondIndex)})
        XCTAssertNil(secondView.value.0)
        XCTAssertNotNil(secondView.value.1)
        XCTAssertEqual(try secondView.value.1.inspect().emptyView().zIndex(), secondIndex)
    }
}

// MARK: Modifiers
extension ViewExtensionsTests {
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
        XCTAssertNil(view.value.0)
        XCTAssertNotNil(view.value.1)
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
        XCTAssertNotNil(secondView.value.0)
        XCTAssertNil(secondView.value.1)
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
        XCTAssertNotNil(firstView.value.0)
        XCTAssertNil(firstView.value.1)
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
        XCTAssertNil(secondView.value.0)
        XCTAssertNotNil(secondView.value.1)
        ViewHosting.host(view: secondView)
        wait(for: [secondExp], timeout: 0.1)
    }
}

// MARK: Animations
extension ViewExtensionsTests {
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
}

// MARK: Combine
extension ViewExtensionsTests {
    func testBindPublisherToState() {
        let subject = PassthroughSubject<Int, Never>()
        let placeholder = 0
        let nextVale = 1

        let view = SubscribedView(source: subject.eraseToAnyPublisher(), placeholder: placeholder, animation: nil)
        XCTAssertEqual(view.$index.wrappedValue, placeholder)
        let exp = view.inspection.inspect { view in
            XCTAssertEqual(try view.actualView().index, placeholder)
            subject.send(nextVale)
        }
        let exp2 = view.inspection.inspect(onReceive: subject) { view in
            XCTAssertEqual(try view.actualView().index, nextVale)
        }
        ViewHosting.host(view: view)
        wait(for: [exp, exp2], timeout: 0.1)
    }
}
