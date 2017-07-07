import Quick
import Nimble
@testable import KeyedAPIParameters

fileprivate struct ConvertibleThing: APIParamConvertible {
    fileprivate func value(forHTTPMethod method: HTTPMethod) -> Any? {
        return "expectedResult"
    }
}


internal final class APIParamValueSpec: QuickSpec {
    internal override func spec() {
        describe("APIParamValue") {
            describe("it's valueForHTTPMethod") {
                context("when the value is") {
                    var value: APIParamValue!
                    
                    context("convertible") {
                        var expected: String!
                        var actual: String!
                        
                        beforeEach {
                            let convertibleThing = ConvertibleThing()
                            value = .convertible(convertibleThing)
                            expected = convertibleThing.value(forHTTPMethod: .get) as! String
                            actual = value.value(forHTTPMethod: .get) as! String
                        }
                        
                        it("should return the value of its valueForHTTPMethod function") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("convertibleArray") {
                        var expected: [String]!
                        var actual: [String]!
                        
                        beforeEach {
                            let convertibleThing = ConvertibleThing()
                            value = .convertibleArray([convertibleThing])
                            expected = [convertibleThing.value(forHTTPMethod: .get) as! String]
                            actual = value.value(forHTTPMethod: .get) as! [String]
                        }
                        
                        it("should return an array of the results the object's valueForHTTPMethod functions") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("null") {
                        var actual: NSNull!
                        
                        beforeEach {
                            value = .null
                            actual = value.value(forHTTPMethod: .get) as! NSNull
                        }
                        
                        it("should return nil") {
                            expect(actual) == NSNull()
                        }
                    }
                    
                    context("timestampInMillis") {
                        context("when the method is get") {
                            var expected: String!
                            var actual: String!
                            
                            beforeEach {
                                let date = Date()
                                value = .timestampInMillis(date)
                                expected = String(describing: date.timeSince1970InMillis)
                                actual = value.value(forHTTPMethod: .get) as! String
                            }
                            
                            it("should return the string value of the date as a timestamp since 1970 in milliseconds") {
                                expect(actual) == expected
                            }
                        }
                        
                        context("when the method is not a get") {
                            var expected: NSNumber!
                            var actual: NSNumber!
                            
                            beforeEach {
                                let date = Date()
                                value = .timestampInMillis(date)
                                expected = NSNumber(value: date.timeSince1970InMillis)
                                actual = value.value(forHTTPMethod: .post) as! NSNumber
                            }
                            
                            it("should return the NSNumber value of the date as a timestamp since 1970 in milliseconds") {
                                expect(actual) == expected
                            }
                        }
                    }
                }
            }
        }
    }
}
