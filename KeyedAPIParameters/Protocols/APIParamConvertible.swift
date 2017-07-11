import Foundation

public protocol APIParamConvertible {
    func value(forHTTPMethod method: HTTPMethod) -> Any
}

extension APIParamConvertible where Self: NumberParamConvertible {
    public func value(forHTTPMethod method: HTTPMethod) -> Any {
        switch method {
            case .get:
                return String(describing: self)
            case .post, .put, .delete:
                return self.toNSNumber()
        }
    }
}

extension String: APIParamConvertible {
    public func value(forHTTPMethod method: HTTPMethod) -> Any {
        return self
    }
}

extension Optional where Wrapped: APIParamConvertible {
    public func value(forHTTPMethod method: HTTPMethod) -> Any {
        switch self {
            case .some(let value): return value.value(forHTTPMethod: method)
            case .none: return NSNull()
        }
    }
}

extension Array where Element: APIParamConvertible {
    public func value(forHTTPMethod method: HTTPMethod) -> Any {
        return self.map { $0.value(forHTTPMethod: method) }
    }
}

extension Int: APIParamConvertible {}
extension Float: APIParamConvertible {}
extension Double: APIParamConvertible {}
extension Bool: APIParamConvertible {}
