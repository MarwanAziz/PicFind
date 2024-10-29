//
//  Item.swift
//  picFind
//
//  Created by Marwan Aziz on 29/10/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
