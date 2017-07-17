import UIKit
import KeyedAPIParameters

struct InnerObject {
    let innerStringProperty: String
}

struct Object {
    let stringProperty: String
    let intProperty: Int
    let floatProperty: Float
    let doubleProperty: Double
    let boolProperty: Bool
    let optionalProperty: String?
    let arrayProperty: [String]
}

extension Object: KeyedAPIParameters {
    enum Key: String, ParamJSONKey {
        case stringProperty
        case intProperty
        case floatProperty
        case doubleProperty
        case boolProperty
        case optionalProperty
        case arrayProperty
    }
    
    func toKeyedDictionary() -> [Key : APIParamValue] {
        return [
            .stringProperty: .convertible(stringProperty),
            .intProperty: .convertible(intProperty),
            .floatProperty: .convertible(intProperty),
            .doubleProperty: .convertible(doubleProperty),
            .boolProperty: .convertible(boolProperty),
            .optionalProperty: .optionalConvertible(optionalProperty),
            .arrayProperty: .arrayConvertible(arrayProperty)
        ]
    }
}
