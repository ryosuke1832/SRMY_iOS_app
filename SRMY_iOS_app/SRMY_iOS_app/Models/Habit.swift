//
//  habit.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//


import Foundation
import SwiftUI

struct Habit: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var goalDays: Int
    var startDate: Date
    var streakCount: Int
    var lastCompletedDate: Date?
    

    init(
        id: UUID = UUID(),
        name: String,
        goalDays: Int,
        startDate: Date = Date(),
        streakCount: Int = 0,
        lastCompletedDate: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.goalDays = goalDays
        self.startDate = startDate
        self.streakCount = streakCount
        self.lastCompletedDate = lastCompletedDate
    }
    

}
