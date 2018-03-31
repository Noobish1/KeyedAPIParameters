import UIKit
import KeyedAPIParameters

struct InnerObject {
    let innerStringProperty: String
}

extension InnerObject: KeyedAPIParameters {
    enum Key: String, ParamJSONKey {
        case innerStringProperty
    }
    
    func toKeyedDictionary() -> [Key : APIParamConvertible] {
        return [.innerStringProperty : innerStringProperty]
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
    
    func toKeyedDictionary() -> [Key : APIParamConvertible] {
        return [
            .stringProperty: stringProperty,
            .intProperty: intProperty,
            .floatProperty: intProperty,
            .doubleProperty: doubleProperty,
            .boolProperty: boolProperty,
            .optionalProperty: optionalProperty,
            .arrayProperty: arrayProperty,
            .nestedProperty: nestedProperty
        ]
    }
}
