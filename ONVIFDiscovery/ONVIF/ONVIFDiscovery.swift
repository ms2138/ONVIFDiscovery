//
//  NoContentBackground.swift
//  ONVIFDiscovery
//
//  Created by mani on 2019-12-02.
//  Copyright © 2019 mani. All rights reserved.
//

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
