//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

// Individual habit List
struct HabitListView: View {
    let habit: Habit
    @ObservedObject var habitService: HabitService
    
    var body: some View {
        HStack {
            Text(habit.name)
            
            Spacer()
            
            // Completion status indicator
            Button {
                habitService.completeHabit(habit)
            } label: {
                Image(systemName: habitService.isHabitCompletedToday(habit) ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(habitService.isHabitCompletedToday(habit) ? .green : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}

