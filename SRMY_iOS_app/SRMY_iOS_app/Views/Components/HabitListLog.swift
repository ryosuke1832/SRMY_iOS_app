//
//  HabitListLog.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/10.
//

import SwiftUI


// Habit-specific log list
struct HabitListLogView: View {
    @EnvironmentObject var habitService: HabitService
    @Binding var selectedHabit: Habit?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(habitService.habits) { habit in
                    Button(action: {
                        selectedHabit = habit
                    }) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(habit.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                HStack {
                                    Image(systemName: "flame.fill")
                                        .foregroundColor(.orange)
                                        .font(.caption)
                                    
                                    Text("Streak: \(habit.streakCount) days")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                
                                if let lastDate = habit.lastCompletedDate {
                                    Text("Last completed: \(formatDate(lastDate))")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}



#Preview("Habit List View") {
    let levelService = LevelService()
    let habitService = HabitService(levelService: levelService)
    
    // Add sample data
    var habit1 = Habit(name: "Running")
    habit1.streakCount = 7
    habit1.lastCompletedDate = Date()
    
    var habit2 = Habit(name: "Drink Water")
    habit2.streakCount = 3
    habit2.lastCompletedDate = Date().addingTimeInterval(-60*60*24*1)
    
    habitService.habits = [habit1, habit2]
    
    return HabitListLogView(selectedHabit: .constant(nil))
        .environmentObject(habitService)
        .environmentObject(levelService)
        .background(
            LinearGradient(colors: [.blue, .mint],
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
            .ignoresSafeArea()
        )
}

