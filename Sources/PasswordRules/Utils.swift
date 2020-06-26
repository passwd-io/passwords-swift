//MARK:- Extensions - Swift

internal extension String {

    @inlinable
    func starts<T>(with possiblePrefix: T) -> Bool where T: RawRepresentable, T.RawValue == String {
        starts(with: possiblePrefix.rawValue)
    }

    @inlinable
    mutating func consume<T>(prefix: T) -> Bool where T: RawRepresentable, T.RawValue == String {
        consume(prefix: prefix.rawValue)
    }

    @inlinable
    mutating func consume(prefix: String) -> Bool {
        guard starts(with: prefix) else {
            return false
        }
        removeFirst(prefix.count)
        return true
    }

    @inlinable
    @discardableResult
    mutating func consume(if shouldConsumeCharacter: (Character) -> Bool) -> String {
        return consume { shouldConsumeCharacter($0.first!) }
    }

    @usableFromInline
    @discardableResult
    mutating func consume(until shouldConsumeNextCharacterOfRemaining: (String) -> Bool) -> String {
        var consumed: String = ""

        while !isEmpty && shouldConsumeNextCharacterOfRemaining(self) {
            consumed.append(removeFirst())
        }

        return consumed
    }
}

internal extension Array where Element == String {

    @inlinable
    func joined(separator: Character) -> String {
        joined(separator: String(separator))
    }
}

//MARK:- Extensions - Foundation

#if canImport(Foundation)
import Foundation

internal extension JSONDecoder {
    func json<T>(_ type: T.Type, from object: Any, options: JSONSerialization.WritingOptions = []) throws -> T where T: Decodable {
        let data = try JSONSerialization.data(withJSONObject: object, options: options)
        return try decode(type, from: data)
    }
}

internal extension JSONEncoder {
    func json<T>(_ value: T, options: JSONSerialization.ReadingOptions = []) throws -> Any where T: Encodable {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: options)
    }
}
#endif
