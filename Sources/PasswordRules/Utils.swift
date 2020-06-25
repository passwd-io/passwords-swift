//MARK:- Extensions - Swift
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
