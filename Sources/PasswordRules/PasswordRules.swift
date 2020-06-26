public struct PasswordRules: Hashable {

    public typealias NonNegativeInteger = UInt

    public var allowed: [CharacterClass] = []

    public var required: [CharacterClass] = []

    public var minLength: NonNegativeInteger? = nil

    public var maxLength: NonNegativeInteger? = nil

    public var maxConsecutive: NonNegativeInteger? = nil

    internal init() {
    }

    internal enum RuleName: String, Hashable, CaseIterable, LosslessStringConvertible {
        case allowed
        case required
        case minLength = "minlength"
        case maxLength = "maxlength"
        case maxConsecutive = "max-consecutive"

        var description: String { rawValue }

        init?(_ description: String) {
            self.init(rawValue: description)
        }
    }

}

//MARK:- LosslessStringConvertible

extension PasswordRules: LosslessStringConvertible {

    public init?(_ description: String) {
        try? self.init(parsing: description)
    }

    public var description: String {
        try! formatted()
    }

    //MARK: Parsing & Formatting

    internal init(parsing string: String, separator: Character =  " ") throws {
        self = try PasswordRulesParser(separator: separator).parse(string)
    }

    internal func formatted(separator: Character =  " ") throws -> String {
        return try PasswordRulesFormatter(separator: separator).format(self)
    }
}

//MARK:- Codable

extension PasswordRules: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        try self.init(parsing: string)
    }

    public func encode(to encoder: Encoder) throws {
        let string = try formatted()
        var container = encoder.singleValueContainer()
        try container.encode(string)
    }
}
