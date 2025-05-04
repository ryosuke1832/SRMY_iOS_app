//
//  habitManager.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import Foundation

@MainActor
class HabitService: ObservableObject {
    @Published var habits: [Habit] = []
    
    init() {
        loadDummyHabits()
    }
    
    // Load dummy habits for testing
    private func loadDummyHabits() {
        habits = [
            Habit(name: "Morning Exercise"),
            Habit(name: "Read for 30 minutes"),
            Habit(name: "Meditate")
        ]
    }
    
    // Mark habit as completed for today
    func completeHabit(_ habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        habits[index].lastCompletedDate = Date()
    }
    
    // Check if habit is completed today
    func isHabitCompletedToday(_ habit: Habit) -> Bool {
        guard let lastCompleted = habit.lastCompletedDate else { return false }
        return Calendar.current.isDateInToday(lastCompleted)
    }
}
