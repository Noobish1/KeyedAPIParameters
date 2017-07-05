import Foundation

public protocol APIParameters: APIParamConvertible {
    func toParamDictionary(forHTTPMethod method: HTTPMethod) -> [String : APIParamValue]
}

extension APIParameters {
    public func toDictionary(forHTTPMethod method: HTTPMethod) -> [String : Any] {
        return toParamDictionary(forHTTPMethod: method).mapFilterValues { $0.value(forHTTPMethod: method) }
    }
    
    public func value(forHTTPMethod method: HTTPMethod) -> Any? {
        return toDictionary(forHTTPMethod: method)
    }
}
