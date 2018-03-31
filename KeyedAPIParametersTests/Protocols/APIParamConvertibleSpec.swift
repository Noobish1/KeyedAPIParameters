import Quick
import Nimble
import Fakery
@testable import KeyedAPIParameters

internal final class APIParamConvertibleSpec: QuickSpec {
    private func testNumberParamConvertible<T: APIParamConvertible>(object objectClosure: @escaping () -> T) where T: NumberParamConvertible  {
        var object: T!
        
        beforeEach {
            object = objectClosure()
        }
        
        context("get") {
            it("should return the number as a string") {
                expect(object.value(forHTTPMethod: .get) as? String) == String(describing: object!)
            }
        }
        
        testNumberParamConvertible("post", object: objectClosure, forNonGetHTTPMethod: { .post })
        testNumberParamConvertible("put", object: objectClosure, forNonGetHTTPMethod: { .put })
        testNumberParamConvertible("delete", object: objectClosure, forNonGetHTTPMethod: { .delete })
    }
    
    private func testNumberParamConvertible<T: APIParamConvertible>(_ contextName: String, object objectClosure: @escaping () -> T, forNonGetHTTPMethod methodClosure: @escaping () -> HTTPMethod) where T: NumberParamConvertible  {
        var method: HTTPMethod!
        var object: T!
        
        beforeEach {
            object = objectClosure()
            method = methodClosure()
        }
        
        context("\(contextName)") {
            it("should return the value wrapped as an NSNumber") {
                expect(object.value(forHTTPMethod: method) as? NSNumber) == object.toNSNumber()
            }
        }
    }
    
    internal override func spec() {
        let faker = Faker()
        
        describe("it's value for HTTPMethod") {
            context("when the object is a") {
                context("String") {
                    var object: String!
                    
                    beforeEach {
                        object = faker.lorem.characters()
                    }
                    
                    it("should return itself") {
                        expect(object.value(forHTTPMethod: .get) as? String) == object
                    }
                }
                
                context("Bool") {
                    testNumberParamConvertible { faker.number.randomBool() }
                }
                
                context("Int") {
                    testNumberParamConvertible { faker.number.randomInt() }
                }
                
                context("Float") {
                    testNumberParamConvertible { faker.number.randomFloat() }
                }
                
                context("Double") {
                    testNumberParamConvertible { faker.number.randomDouble() }
                }
                
                context("optionalConvertible") {
                    context("when the given value is nil") {
                        var actual: NSNull!
                        var object: String?
                        
                        beforeEach {
                            object = nil
                            actual = object.value(forHTTPMethod: .get) as! NSNull
                        }
                        
                        it("should return NSNull") {
                            expect(actual) == NSNull()
                        }
                    }
                        
                    context("when the given is not nil") {
                        var expected: String!
                        var actual: String!
                        var object: String?
                        
                        beforeEach {
                            expected = "expected"
                            object = expected
                            actual = object.value(forHTTPMethod: .get) as! String
                        }
                        
                        it("should return the result of calling valueForHTTPMethod on that value") {
                            expect(actual) == expected
                        }
                    }
                }
                
                    context("arrayConvertible") {
                        var actual: [String]!
                        var expected: [String]!
                        
                        beforeEach {
                            expected = ["expected"]
                            actual = expected.value(forHTTPMethod: .get) as! [String]
                        }
                        
                        it("should return an array of the results of calling valueForHTTPMethod on each of its elements") {
                            expect(actual) == expected
                        }
                    }
                
                    context("null") {
                        var actual: NSNull!
                        var expected: NSNull!
                        
                        beforeEach {
                            expected = NSNull()
                            actual = expected.value(forHTTPMethod: .get) as! NSNull
                        }
                        
                        it("should return NSNull") {
                            expect(actual) == expected
                        }
                    }
            }
        }
    }
}
