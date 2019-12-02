
import Foundation

struct ONVIFDiscovery {
    let model: String
    let ipAddress: String
    let deviceService: URL
}

extension ONVIFDiscovery: Equatable {
    static func == (lhs: ONVIFDiscovery, rhs: ONVIFDiscovery) -> Bool {
        return lhs.ipAddress == rhs.ipAddress
    }
}
