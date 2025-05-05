//
//  habitManager.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import Foundation

class HabitService: ObservableObject {
    @Published var habits: [Habit] = []
    
    private let saveKey = "SavedHabits"
    
    init() {
        loadHabits()
    }
    
    // add habit
    func addHabit(name: String, goalDays: Int) {
        let newHabit = Habit(name: name, goalDays: goalDays)
        habits.append(newHabit)
        saveHabits()
    }
    

    // update habit
    func updateHabit(_ habit: Habit, name: String? = nil, goalDays: Int? = nil) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
        
            // update habit by new property
            var updatedHabit = habit
            
            if let name = name {
                updatedHabit.name = name
            }
            
            if let goalDays = goalDays {
                updatedHabit.goalDays = goalDays
            }
        
            // save updated habit
            habits[index] = updatedHabit
            saveHabits()
        }
    }
    
    // delete habit
    func deleteHabit(_ habit: Habit) {
        habits.removeAll { $0.id == habit.id }
        saveHabits()
    }
    
    // Mark habit as completed for today
    func markHabitAsCompleted(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            let today = Calendar.current.startOfDay(for: Date())
            
            // if it exist for lastCompleteDate
            if let lastCompleted = habit.lastCompletedDate {
                let lastCompletedDay = Calendar.current.startOfDay(for: lastCompleted)
                let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
                
                // continious complete if yesterday have completed as well
                if Calendar.current.isDate(lastCompletedDay, inSameDayAs: yesterday) {
                    habits[index].streakCount += 1
                } else if !Calendar.current.isDate(lastCompletedDay, inSameDayAs: today) {
                    // if not yesterday not today, reset continuious log
                    habits[index].streakCount = 1
                }
            } else {
                // first complete
                habits[index].streakCount = 1
            }
            
            habits[index].lastCompletedDate = today
            saveHabits()
        }
    }
    
    // Check if habit is completed today
    func isCompletedToday(_ habit: Habit) -> Bool {
        guard let lastCompleted = habit.lastCompletedDate else { return false }
        let today = Calendar.current.startOfDay(for: Date())
        let lastCompletedDay = Calendar.current.startOfDay(for: lastCompleted)
        
        return Calendar.current.isDate(lastCompletedDay, inSameDayAs: today)
    }
    
    // check goal is achieved or not
    func isGoalAchieved(_ habit: Habit) -> Bool {
        return habit.streakCount >= habit.goalDays
    }
    
    // save habot
    private func saveHabits() {
        do {
            let encodedData = try JSONEncoder().encode(habits)
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        } catch {
            print("Failed to save habits: \(error)")
        }
    }
    
    // load habit
    private func loadHabits() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            do {
                habits = try JSONDecoder().decode([Habit].self, from: savedData)
            } catch {
                print("Failed to load habits: \(error)")
            }
        }
    }
    
    // Calculation of habit progress rate(%)
    func progressPercentage(for habit: Habit) -> Double {
        return min(Double(habit.streakCount) / Double(habit.goalDays), 1.0) * 100.0
    }
    
    // Calculation of habit progress rate（0.0〜1.0）
    func progressRatio(for habit: Habit) -> Double {
        return min(Double(habit.streakCount) / Double(habit.goalDays), 1.0)
    }

    // format Date
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }


}
