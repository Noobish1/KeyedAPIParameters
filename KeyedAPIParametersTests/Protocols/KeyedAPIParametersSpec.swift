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
    
    public func toKeyedDictionary() -> [Key : APIParamConvertible] {
        return [.property : property]
    }
}

internal final class KeyedAPIParametersSpec: QuickSpec {
    internal override func spec() {
        describe("KeyedAPIParameters") {
            let faker = Faker()
            
            describe("it's toParamDictionary") {
                it("should return of its conformers toKeyedDictionary function with the keys mapped to their string values") {
                    let thing = KeyedAPIParamsThing(property: faker.lorem.characters())
                    
                    let expected = thing.toKeyedDictionary().mapKeys { $0.stringValue }.mapValues { $0.value(forHTTPMethod: .get) }
                    let actual = thing.toParamDictionary().mapValues { $0.value(forHTTPMethod: .get) }
                    
                    expect(actual as? [String : String]) == (expected as? [String : String])
                }
            }
        }
    }
}
