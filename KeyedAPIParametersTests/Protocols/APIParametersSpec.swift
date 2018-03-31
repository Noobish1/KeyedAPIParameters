import Quick
import Nimble
import Fakery
@testable import KeyedAPIParameters

fileprivate struct ParamThing {
    fileprivate let property: String
}

extension ParamThing: APIParameters {
    fileprivate func toParamDictionary() -> [String : APIParamConvertible] {
        return ["stringProperty" : property]
    }
}

internal final class APIParametersSpec: QuickSpec {
    internal override func spec() {
        describe("APIParameters") {
            let faker = Faker()
            
            describe("it's toDictionary") {
                var actual: [String : String]!
                var expected: [String : String]!
                
                beforeEach {
                    let property = faker.lorem.characters()
                    let thing = ParamThing(property: property)
                    actual = thing.toDictionary(forHTTPMethod: .get) as! [String : String]
                    expected = ["stringProperty" : property]
                }
                
                it("should take the result of the toParamDictionary function and turn the values of the dictionary into their valueForHTTPMethod") {
                    expect(actual) == expected
                }
            }
            
            describe("it's valueForHTTPMethod") {
                var actual: [String : String]!
                var expected: [String : String]!
                
                beforeEach {
                    let property = faker.lorem.characters()
                    let thing = ParamThing(property: property)
                    actual = thing.value(forHTTPMethod: .get) as! [String : String]
                    expected = ["stringProperty" : property]
                }
                
                it("should return the same result as the toDictionary function") {
                    expect(actual) == expected
                }
            }
        }
    }
}
