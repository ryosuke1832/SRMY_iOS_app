//
//  LogView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/10.
//
import SwiftUI

struct LogView: View {
    @EnvironmentObject var habitService: HabitService
    @State private var selectedTab = 0
    @State private var selectedHabit: Habit? = nil
    @Binding var tabBarSelection: Int
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(colors: [.blue, .mint],
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                // Header
                Text("Activity Log")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 3)
                    .padding(.top)
                
                // Tab switcher
                Picker("View Mode", selection: $selectedTab) {
                    Text("Calendar").tag(0)
                    Text("By Habit").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedTab == 0 {
                    // Calendar view
                    CalendarLogView()
                } else {
                    // Habit-specific view
                    HabitListLogView(selectedHabit: $selectedHabit)
                }
                
                Spacer()
                    .padding(.bottom, 0)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .sheet(item: $selectedHabit) { habit in
            HabitDetailView(habit: habit)
        }
    }
}

// Preview helper functions
#Preview {
    struct PreviewWrapper: View {
        @State private var tabBarSelection = 1  //
        
        var body: some View {
            let levelService = LevelService()
            let habitService = HabitService(levelService: levelService)
            
            // Create sample data
            let habit1 = Habit(name: "Running", startDate: Date().addingTimeInterval(-60*60*24*10))
            let habit2 = Habit(name: "Drink Water", startDate: Date().addingTimeInterval(-60*60*24*20))
            let habit3 = Habit(name: "Reading", startDate: Date().addingTimeInterval(-60*60*24*5))
            
            // Add history data
            var habit1WithHistory = habit1
            habit1WithHistory.streakCount = 7
            habit1WithHistory.lastCompletedDate = Date()
            
            var habit2WithHistory = habit2
            habit2WithHistory.streakCount = 3
            habit2WithHistory.lastCompletedDate = Date().addingTimeInterval(-60*60*24*1)
            
            var habit3WithHistory = habit3
            habit3WithHistory.streakCount = 5
            habit3WithHistory.lastCompletedDate = Date()
            
            // Add to service
            habitService.habits = [habit1WithHistory, habit2WithHistory, habit3WithHistory]
            
            // Preview LogView
            return LogView(tabBarSelection: $tabBarSelection)
                .environmentObject(levelService)
                .environmentObject(habitService)
        }
    }
    
    return PreviewWrapper()
}
