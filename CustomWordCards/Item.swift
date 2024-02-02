//
//  Item.swift
//  CustomWordCards
//
//  Created by 游尚諺 on 2024/1/31.
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
