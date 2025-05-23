//
//  habitManager.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import Foundation

class HabitService: ObservableObject {
    @Published var habits: [Habit] = []
    @Published var recentlyCompleted: Set<UUID> = []
    
    private let saveKey = "SavedHabits"
    private let levelService: any LevelServiceProtocol
    
    init(levelService: any LevelServiceProtocol) {
        self.levelService = levelService
        loadHabits()
    }
    

    
    // add habit
    func addHabit(name: String) {
//        let newHabit = Habit(name: name, goalDays: goalDays)
        let newHabit = Habit(name: name)
        habits.append(newHabit)
        saveHabits()
    }
    

    // update habit
    func updateHabit(_ habit: Habit, name: String? = nil) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
        
            // update habit by new property
            var updatedHabit = habit
            
            if let name = name {
                updatedHabit.name = name
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
            
            // ---------- XP awarding ----------
            let completedToday = habits.filter { isCompletedToday($0) }.count - 1
            let comboIndex     = max(0, completedToday)                            //count the total task completed today
            let streak         = habits[index].streakCount                         //get streak

            levelService.awardXP(habitID: habit.id,base: 25, comboIndex: comboIndex, streak: streak)  //call levelService
            // ----------------------------------
            recentlyCompleted.insert(habit.id)                                    //delay vanish row
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.recentlyCompleted.remove(habit.id)
            }
            habits[index].completionHistory.append(today)

            saveHabits()
        }
    }
    
    // Simulate disappearance after a short animation
    func completeHabitWithDelay(_ habit: Habit) {
        markHabitAsCompleted(habit)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.habits.removeAll { $0.id == habit.id }
//        }
    }
    
    
    // get histroy of completion of habits 
    func completionHistoryForLast(days: Int, for habit: Habit) -> [Bool] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return (0..<days).map { dayOffset in
            let targetDate = calendar.date(byAdding: .day, value: -dayOffset, to: today)!
            return habit.completionHistory.contains { calendar.isDate($0, inSameDayAs: targetDate) }
        }
    }

    
    // Check if habit is completed today
    func isCompletedToday(_ habit: Habit) -> Bool {
        guard let lastCompleted = habit.lastCompletedDate else { return false }
        let today = Calendar.current.startOfDay(for: Date())
        let lastCompletedDay = Calendar.current.startOfDay(for: lastCompleted)
        
        return Calendar.current.isDate(lastCompletedDay, inSameDayAs: today)
    }
    

    
    // save habit
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



    // format Date
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }


}
