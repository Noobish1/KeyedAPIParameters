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
                
                context("Optional") {
                    context("when the wrapped value is non-nil") {
                        var actual: String!
                        var expected: String!
                        
                        beforeEach {
                            let nonOptionalString = faker.lorem.characters()
                            let object: String? = nonOptionalString
                            actual = object.value(forHTTPMethod: .get) as! String
                            expected = nonOptionalString.value(forHTTPMethod: .get) as! String
                        }
                        
                        it("should return the result of that value after valueForHTTPMethod called apon it") {
                            expect(actual) == expected
                        }
                    }
                    
                    context("when the wrapped value is nil") {
                        var object: String?
                        var actual: NSNull!
                        
                        beforeEach {
                            object = nil
                            actual = object.value(forHTTPMethod: .get) as! NSNull
                        }
                        
                        it("should return NSNull") {
                            expect(actual) == NSNull()
                        }
                    }
                }
                
                context("An Array of APIParamConvertible elements") {
                    var actual: [String]!
                    var expected: [String]!
                    
                    beforeEach {
                        let element = faker.lorem.characters()
                        let array = [element]
                        actual = array.value(forHTTPMethod: .get) as! [String]
                        expected = [element.value(forHTTPMethod: .get) as! String]
                    }
                    
                    it("should return an array of the result of calling valueForHTTPMethod on each of the elements") {
                        expect(actual) == expected
                    }
                }
            }
        }
    }
}
