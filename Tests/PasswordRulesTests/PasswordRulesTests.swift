import XCTest
@testable import PasswordRules

final class PasswordRulesTests: XCTestCase {

    func testBasicFormattingAndParsing() {

        let separator: Character = " "

        let expectedFormattedRules = [
            "required: upper;",
            "required: lower;",
            "required: special;",
            "allowed: ascii-printable;",
            "minlength: 20;",
            "maxlength: 32;",
            "max-consecutive: 2;",
        ].joined(separator: separator)

        let expectedParsedRules = PasswordRulesBuilder()
            .require(.upper)
            .require(.lower)
            .require(.special)
            .allow(.asciiPrintable)
            .minLength(20)
            .maxLength(32)
            .maxConsecutive(2)
            .build()

        let actualFormattedRules = try! expectedParsedRules.formatted(separator: separator)
        XCTAssertEqual(actualFormattedRules, expectedFormattedRules)

        let actualParsedRules = try! PasswordRules(parsing: expectedFormattedRules, separator: separator)
        XCTAssertEqual(actualParsedRules, expectedParsedRules)
    }

    static var allTests = [
        ("testBasicFormattingAndParsing", testBasicFormattingAndParsing),
    ]
}
