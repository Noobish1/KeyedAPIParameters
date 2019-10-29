import UIKit
import KeyedAPIParameters

struct InnerObject {
    let innerStringProperty: String
}

extension InnerObject: KeyedAPIParameters {
    enum Key: String, ParamJSONKey {
        case innerStringProperty
    }
    
    func param(for key: Key) -> APIParamConvertible {
        switch key {
            case .innerStringProperty: return innerStringProperty
        }
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
    
    func param(for key: Key) -> APIParamConvertible {
        switch key {
            case .stringProperty: return stringProperty
            case .intProperty: return intProperty
            case .floatProperty: return intProperty
            case .doubleProperty: return doubleProperty
            case .boolProperty: return boolProperty
            case .optionalProperty: return optionalProperty
            case .arrayProperty: return arrayProperty
            case .nestedProperty: return nestedProperty
        }
    }
}
