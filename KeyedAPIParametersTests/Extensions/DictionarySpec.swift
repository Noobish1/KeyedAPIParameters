import Quick
import Nimble
@testable import KeyedAPIParameters

class DictionarySpec: QuickSpec {
    override func spec() {
        describe("Dictionary") {
            describe("mapKeys") {
                it("should transform the dictionary's keys into the correct values") {
                    let dict = ["one" : 1, "two" : 2]
                    let expectedKeys = ["onemapped", "twomapped"]
                    let actualKeys = Array(dict.mapKeys { $0.appending("mapped") }.keys)
                    
                    expect(actualKeys).to(contain(expectedKeys))
                    expect(actualKeys.count) == 2
                }
            }
        }
    }
}
