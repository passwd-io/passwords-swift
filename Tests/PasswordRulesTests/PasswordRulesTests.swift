import XCTest
@testable import PasswordRules

final class PasswordRulesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PasswordRules().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
