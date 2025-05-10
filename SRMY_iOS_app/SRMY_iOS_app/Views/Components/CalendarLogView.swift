//
//  CalendarLogView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/10.
//

import SwiftUI


// Calendar-based log display
struct CalendarLogView: View {
    @EnvironmentObject var habitService: HabitService
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            // Simple calendar
            DatePicker("Select date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
                .padding(.horizontal)
            
            // Display habits completed on selected date
            VStack(alignment: .leading) {
                Text("Habits completed on \(formatDate(selectedDate))")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                if habitsForSelectedDate().isEmpty {
                    VStack {
                        Text("No habits completed on this day")
                            .foregroundColor(.white.opacity(0.7))
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(habitsForSelectedDate()) { habit in
                                HabitLogRow(habit: habit)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top)
            
            Spacer()
        }
    }
    
    func habitsForSelectedDate() -> [Habit] {
        return habitService.habits.filter { habit in
            habit.completionHistory.contains { date in
                Calendar.current.isDate(date, inSameDayAs: selectedDate)
            }
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}



// Individual component previews
#Preview("Calendar Log View") {
    let levelService = LevelService()
    let habitService = HabitService(levelService: levelService)
    
    // Add sample data
    var habit1 = Habit(name: "Running")
    habit1.streakCount = 7
    habit1.lastCompletedDate = Date()
    habit1.completionHistory = [
        Date(),
        Date().addingTimeInterval(-60*60*24*2),
        Date().addingTimeInterval(-60*60*24*4)
    ]
    
    
    var habit2 = Habit(name: "Drink Water")
    habit2.streakCount = 3
    habit2.lastCompletedDate = Date().addingTimeInterval(-60*60*24*1)
    habit2.completionHistory = [
        Date().addingTimeInterval(-60*60*24*1),
        Date().addingTimeInterval(-60*60*24*2),
        Date().addingTimeInterval(-60*60*24*3)  
    ]
    
    habitService.habits = [habit1, habit2]
    
    return CalendarLogView()
        .environmentObject(habitService)
        .environmentObject(levelService)
        .background(
            LinearGradient(colors: [.blue, .mint],
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
            .ignoresSafeArea()
        )
}
