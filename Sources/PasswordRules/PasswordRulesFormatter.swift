extension PasswordRules {

    public enum FormattingError: Error {
        case invalidSeparator(Character)
    }
}

internal struct PasswordRulesFormatter {

    private typealias FormattingError = PasswordRules.FormattingError

    private let separator: Character

    internal init(separator: Character) throws {
        guard separator.isWhitespace else {
            throw PasswordRules.FormattingError.invalidSeparator(separator)
        }
        self.separator = separator
    }

    internal func format(_ rules: PasswordRules) -> String {
        let properties: [String]
            = rules.required.map { "required: \($0)" }
            + rules.allowed.map { "allowed: \($0)" }
            + [rules.minLength].compactMap { $0 }.map { "minlength: \($0)" }
            + [rules.maxLength].compactMap { $0 }.map { "maxlength: \($0)" }
            + [rules.maxConsecutive].compactMap { $0 }.map { "max-consecutive: \($0)" }

        return properties.map { $0 + ";" }.joined(separator: separator)
    }
}
