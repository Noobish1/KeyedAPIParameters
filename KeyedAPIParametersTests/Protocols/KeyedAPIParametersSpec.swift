import Quick
import Nimble
import Fakery
@testable import KeyedAPIParameters

fileprivate struct KeyedAPIParamsThing {
    fileprivate let property: String
}

extension KeyedAPIParamsThing: KeyedAPIParameters {
    public enum Key: String, ParamJSONKey {
        case property
    }
    
    public func param(for key: Key) -> APIParamConvertible {
        switch key {
            case .property: return property
        }
    }
}

internal final class KeyedAPIParametersSpec: QuickSpec {
    internal override func spec() {
        describe("KeyedAPIParameters") {
            let faker = Faker()
            
            describe("it's toParamDictionary") {
                it("should return its conformers keys as strings mapped to their param values") {
                    let thing = KeyedAPIParamsThing(property: faker.lorem.characters())
                    
                    let keysAndValues = KeyedAPIParamsThing.Key.allCases.map { ($0, thing.param(for: $0)) }
                    let expected = Dictionary(uniqueKeysWithValues: keysAndValues).mapKeys { $0.stringValue }
                    let actual = thing.toParamDictionary().mapValues { $0.value(forHTTPMethod: .get) }
                    
                    expect(actual as? [String : String]) == (expected as? [String : String])
                }
            }
        }
    }
}
