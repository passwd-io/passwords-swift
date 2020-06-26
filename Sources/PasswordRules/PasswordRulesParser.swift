extension PasswordRules {

    public enum ParsingError: Error {
        case invalidSeparator(Character)
        case invalidString(String)
        case endOfInput
        case invalidValue(rule: String, value: String)
        case duplicateValue(rule: String, value: String)
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

    internal func parse(_ input: String) throws -> PasswordRules {
        var input = input

        var passwordRules = PasswordRules()

        while true {
            input.consume(if: \.isWhitespace)
            if input.isEmpty { break }

            let ruleName = try Self.consumeRuleName(&input)

            switch ruleName {

            case .allowed:
                passwordRules.allowed += try Self.consumeCharacterClassList(&input)

            case .required:
                passwordRules.required += try Self.consumeCharacterClassList(&input)

            case .minLength:
                let value = try Self.consumeNonNegativeInteger(&input)
                guard passwordRules.minLength == nil else {
                    throw ParsingError.duplicateValue(rule: ruleName.rawValue, value: "\(value)")
                }
                passwordRules.minLength = value

            case .maxLength:
                let value = try Self.consumeNonNegativeInteger(&input)
                guard passwordRules.maxLength == nil else {
                    throw ParsingError.duplicateValue(rule: ruleName.rawValue, value: "\(value)")
                }
                passwordRules.maxLength = value

            case .maxConsecutive:
                let value = try Self.consumeNonNegativeInteger(&input)
                guard passwordRules.maxConsecutive == nil else {
                    throw ParsingError.duplicateValue(rule: ruleName.rawValue, value: "\(value)")
                }
                passwordRules.maxConsecutive = value
            }
        }

        assert(input.isEmpty)
        return passwordRules
    }

    private typealias RuleName = PasswordRules.RuleName

    private typealias NonNegativeInteger = PasswordRules.NonNegativeInteger

    private static func consumeRuleName(_ input: inout String) throws -> RuleName {

        let propertyValueStartSentinel = ":"

        input.consume(if: \.isWhitespace)

        let ruleName = RuleName.allCases.first {
            input.starts(with: "\($0)\(propertyValueStartSentinel)")
        }

        guard ruleName != nil else {
            throw ParsingError.invalidString(input)
        }

        assert(input.consume(prefix: ruleName!))
        assert(input.consume(prefix: ":"))

        input.consume(if: \.isWhitespace)

        return ruleName!
    }

    private static func consumeCharacterClassList(_ input: inout String) throws -> [CharacterClass] {

        var charClasses: [CharacterClass] = []

        while true {
            input.consume(if: \.isWhitespace)
            if input.isEmpty { throw ParsingError.endOfInput }

            charClasses.append(try consumeCharacterClass(&input))
            input.consume(if: \.isWhitespace)

            if input.consume(prefix: ";") {
                break
            }

            if !input.consume(prefix: ",") {
                throw ParsingError.invalidString(input)
            }
        }

        return charClasses
    }

    private static func consumeCharacterClass(_ input: inout String) throws -> CharacterClass {

        input.consume(if: \.isWhitespace)

        let namedClass = CharacterClass.Named.allCases.first {
            input.starts(with: $0)
        }

        if namedClass != nil {
            assert(input.consume(prefix: namedClass!))
            input.consume(if: \.isWhitespace)
            return .named(namedClass!)
        }

        throw ParsingError.invalidString(input)
    }

    private static func consumeNonNegativeInteger(_ input: inout String) throws -> NonNegativeInteger {
        let value = input.consume(if: \.isNumber)

        if value.isEmpty {
            throw ParsingError.invalidString(input)
        }

        if !input.consume(prefix: ";") {
            throw ParsingError.invalidString(input)
        }

        return NonNegativeInteger(value)!
    }
}
