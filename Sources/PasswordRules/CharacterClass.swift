public enum CharacterClass: Hashable {

    case named(Named)
}

extension CharacterClass {

    public enum Named: String, Hashable {

        /// `A-Z`
        case upper

        /// `a-z`
        case lower

        /// `0-9`
        case digit

        /// ``- ~ ! @ # $ % ^ & * _ + = ` | ( ) { } [ : ; " ' < > , . ? ]`` and `space`
        case special

        /// all ASCII printable characters
        case asciiPrintable = "ascii-printable"

        /// all unicode characters
        case unicode
    }
}

//MARK:- LosslessStringConvertible

extension CharacterClass: LosslessStringConvertible {

    public init?(_ description: String) {
        if let charClass = Named(description) {
            self = .named(charClass)
        }
        return nil
    }

    public var description: String {
        switch self {
        case .named(let charClass):
            return charClass.description
        }
    }
}

extension CharacterClass.Named: LosslessStringConvertible {

    public var description: String {
        return rawValue
    }

    public init?(_ description: String) {
        self.init(rawValue: description)
    }
}

//MARK:- Codable

extension CharacterClass: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let charClass = try container.decode(Named.self)
        self = .named(charClass)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .named(let charClass):
            try container.encode(charClass)
        }
    }
}

extension CharacterClass.Named: Codable {
}
