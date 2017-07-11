import Quick
import Nimble
@testable import KeyedAPIParameters

fileprivate enum ParamJSONThing: String, ParamJSONKey {
    case first
    case last
}

internal final class ParamJSONKeySpec: QuickSpec {
    internal override func spec() {
        describe("it's stringValue") {
            context("when the conformer's rawValue is a String") {
                it("should return rawValue") {
                    expect(ParamJSONThing.first.stringValue) == ParamJSONThing.first.rawValue
                }
            }
        }
    }
}
