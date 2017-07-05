import Foundation

public extension Dictionary {
    public func mapKeys <K> (_ map: (Key) throws -> K) rethrows -> [K: Value] {
        var mapped = [K: Value]()
        
        try forEach { mapped[try map($0)] = $1 }
        
        return mapped
    }
    
    public func mapFilterValues <V> (_ map: (Value) -> V?) -> [Key: V] {
        var mapped = [Key: V]()
        
        forEach {
            if let value = map($1) {
                mapped[$0] = value
            }
        }
        
        return mapped
    }
}
