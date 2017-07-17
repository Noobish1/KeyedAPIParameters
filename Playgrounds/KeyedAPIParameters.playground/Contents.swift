import UIKit
import KeyedAPIParameters

struct InnerObject {
    let innerStringProperty: String
}

extension InnerObject: KeyedAPIParameters {
    enum Key: String, ParamJSONKey {
        case innerStringProperty
    }
    
    func toKeyedDictionary() -> [Key : APIParamValue] {
        return [.innerStringProperty : .convertible(innerStringProperty)]
    }
}

struct Object {
    let stringProperty: String
    let intProperty: Int
    let floatProperty: Float
    let doubleProperty: Double
    let boolProperty: Bool
    let optionalProperty: String?
    let arrayProperty: [String]
    let nestedProperty: InnerObject
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
        case nestedProperty
    }
    
    func toKeyedDictionary() -> [Key : APIParamValue] {
        return [
            .stringProperty: .convertible(stringProperty),
            .intProperty: .convertible(intProperty),
            .floatProperty: .convertible(intProperty),
            .doubleProperty: .convertible(doubleProperty),
            .boolProperty: .convertible(boolProperty),
            .optionalProperty: .optionalConvertible(optionalProperty),
            .arrayProperty: .arrayConvertible(arrayProperty),
            .nestedProperty: .convertible(nestedProperty)
        ]
    }
}
