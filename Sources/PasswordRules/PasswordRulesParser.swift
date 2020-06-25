extension PasswordRules {

    public enum ParsingError: Error {
        case invalidSeparator(Character)
    }
}

internal struct PasswordRulesParser {

    private typealias ParsingError = PasswordRules.ParsingError

    private let separator: Character

    internal init(separator: Character) throws {
        guard separator.isWhitespace else {
            throw ParsingError.invalidSeparator(separator)
        }
        self.separator = separator
    }

    internal func parse(_ string: String) throws -> PasswordRules {
        fatalError() //TODO: Implement
    }
}
