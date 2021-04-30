import XCTest
@testable import SwiftUtility

final class SwiftUtilityTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftUtility().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
