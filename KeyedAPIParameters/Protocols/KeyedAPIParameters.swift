import Foundation

public protocol KeyedAPIParameters: APIParameters {
    associatedtype Key: ParamJSONKey
    
    func param(for key: Key) -> APIParamConvertible
}

extension KeyedAPIParameters {
    public func toParamDictionary() -> [String : APIParamConvertible] {
        let keysAndParams = Key.allCases.map { ($0, param(for: $0)) }
        
        return Dictionary(uniqueKeysWithValues: keysAndParams).mapKeys { $0.stringValue }
    }
}
