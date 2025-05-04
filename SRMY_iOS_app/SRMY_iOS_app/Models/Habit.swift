//
//  habit.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import Foundation
import SwiftUI

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var lastCompletedDate: Date?
    
    init(
        id: UUID = UUID(),
        name: String,
        lastCompletedDate: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.lastCompletedDate = lastCompletedDate
    }
}
