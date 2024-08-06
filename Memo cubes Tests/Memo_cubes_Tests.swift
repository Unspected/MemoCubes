import XCTest
@testable import Memo_cubes

final class Memo_cubes_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }


}

extension XCTestCase {

    func assertDeallocation<T: AnyObject>(
        of object: () -> T,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        weak var weakReferenceToObject: T?

        let autoreleasepoolExpectation = expectation(description: "Autoreleasepool should drain")

        autoreleasepool {
            let object = object()

            weakReferenceToObject = object

            XCTAssertNotNil(weakReferenceToObject)

            autoreleasepoolExpectation.fulfill()
        }

        wait(for: [autoreleasepoolExpectation], timeout: 10.0)

        wait(
            for: weakReferenceToObject == nil,
            timeout: 3.0,
            description: "The object should be deallocated since no strong reference points to it.",
            file: file,
            line: line
        )
    }

    func wait(
        for condition: @autoclosure @escaping () -> Bool,
        timeout: TimeInterval,
        description: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let end = Date().addingTimeInterval(timeout)

        var value: Bool = false
        let closure: () -> Void = {
            value = condition()
        }

        while !value && 0 < end.timeIntervalSinceNow {
            if RunLoop.current.run(mode: RunLoop.Mode.default, before: Date(timeIntervalSinceNow: 0.002)) {
                Thread.sleep(forTimeInterval: 0.002)
            }
            closure()
        }

        closure()

        XCTAssertTrue(
            value,
            "➡️? Timed out waiting for condition to be true: \"\(description)\"",
            file: file,
            line: line
        )
    }
}
