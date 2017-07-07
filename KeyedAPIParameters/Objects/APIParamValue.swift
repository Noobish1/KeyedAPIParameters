import Foundation

public enum APIParamValue: APIParamConvertible {
    case convertible(APIParamConvertible)
    case convertibleArray([APIParamConvertible])
    case null
    case timestampInMillis(Date)

    public func value(forHTTPMethod method: HTTPMethod) -> Any? {
        switch self {
            case .convertible(let convertibleValue):
                return convertibleValue.value(forHTTPMethod: method)
            case .convertibleArray(let array):
                return array.flatMap { $0.value(forHTTPMethod: method) }
            case .null:
                return NSNull()
            case .timestampInMillis(let date):
                switch method {
                    case .get:
                        return String(describing: date.timeSince1970InMillis)
                    case .post, .put, .delete:
                        return NSNumber(value: date.timeSince1970InMillis)
                }
        }
    }
}
