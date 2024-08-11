import XCTest
@testable import Memo_cubes


final class Memo_cubes_Tests: XCTestCase {
    
    func testAddCubes() async throws {
        let vmMock = await GameViewModelMock()
        
        if let randomCube = await vmMock.cubes.randomElement(), let randomCube2 = await vmMock.cubes.randomElement() {
                await vmMock.onTapCube(cube: randomCube)
                await vmMock.onTapCube(cube: randomCube2)
                let actualResult = await vmMock.selectedCubes.count
                XCTAssertEqual(actualResult, 2, "Added cubes wasn't added")
        }
    }
    
    func testMatchingCubes() async throws {
        let vmMock = await GameViewModelMock()
        let samePair = await vmMock.cubes.filter { $0.imageName == "pharaoh" }
        let compareResult = await vmMock.matchingCubes(cubes: samePair)
        XCTAssertTrue(compareResult)
    }
    
    func testUnMatchingCubes() async throws {
        let vmMock = await GameViewModelMock()
        let notMatchPair = await vmMock.cubes.filter { $0.imageName != $0.imageName }
        let comparableResult = await vmMock.matchingCubes(cubes: notMatchPair)
        XCTAssertFalse(comparableResult)
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
