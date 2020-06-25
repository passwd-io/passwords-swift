public class PasswordRulesBuilder {

    private var rules: PasswordRules

    public init() {
        rules = PasswordRules()
    }

    @discardableResult
    public func allow(_ charClass: CharacterClass) -> PasswordRulesBuilder {
        rules.allowed.append(charClass)
        return self
    }

    @discardableResult
    public func require(_ charClass: CharacterClass) -> PasswordRulesBuilder {
        rules.required.append(charClass)
        return self
    }

    @discardableResult
    public func minLength(_ length: PasswordRules.NonNegativeInteger) -> PasswordRulesBuilder {
        rules.minLength = length
        return self
    }

    @discardableResult
    public func maxLength(_ length: PasswordRules.NonNegativeInteger) -> PasswordRulesBuilder {
        rules.maxLength = length
        return self
    }

    @discardableResult
    public func maxConsecutive(_ length: PasswordRules.NonNegativeInteger) -> PasswordRulesBuilder {
        rules.maxConsecutive = length
        return self
    }

    public func build() -> PasswordRules {
        let finalRules = rules
        rules = PasswordRules()
        return finalRules
    }
}

//MARK:- Syntactic Sugar

extension PasswordRulesBuilder {

    @inlinable
    @discardableResult
    public func allow(_ charClass: CharacterClass.Named) -> PasswordRulesBuilder {
        return allow(.named(charClass))
    }

    @inlinable
    @discardableResult
    public func require(_ charClass: CharacterClass.Named) -> PasswordRulesBuilder {
        return require(.named(charClass))
    }
}
