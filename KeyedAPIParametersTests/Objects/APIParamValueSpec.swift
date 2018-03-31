import Quick
import Nimble
@testable import KeyedAPIParameters

fileprivate struct ConvertibleThing: APIParamConvertible {
    fileprivate func value(forHTTPMethod method: HTTPMethod) -> Any {
        return "expectedResult"
    }
}


//internal final class APIParamValueSpec: QuickSpec {
//    internal override func spec() {
//        describe("APIParamValue") {
//            describe("it's valueForHTTPMethod") {
//                context("when the value is") {
//                    var value: APIParamValue!
//
//                    context("convertible") {
//                        var expected: String!
//                        var actual: String!
//
//                        beforeEach {
//                            let convertibleThing = ConvertibleThing()
//                            value = .convertible(convertibleThing)
//                            expected = convertibleThing.value(forHTTPMethod: .get) as! String
//                            actual = value.value(forHTTPMethod: .get) as! String
//                        }
//
//                        it("should return the value of its valueForHTTPMethod function") {
//                            expect(actual) == expected
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
