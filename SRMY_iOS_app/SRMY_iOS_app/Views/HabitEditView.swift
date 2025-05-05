//
//  HabitEditView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/05.
//

import SwiftUI

struct HabitEditView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var habitService: HabitService
    
    var habit: Habit
    
    @State private var habitName: String
    @State private var goalDays: Int
    
    init(habit: Habit) {
        self.habit = habit
        _habitName = State(initialValue: habit.name)
        _goalDays = State(initialValue: habit.goalDays)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habit Details")) {
                    TextField("Name", text: $habitName)
                    
                    Stepper(value: $goalDays, in: 1...365) {
                        HStack {
                            Text("Goal")
                            Spacer()
                            Text("\(goalDays) days")
                        }
                    }
                }
                
                Section {
                    Button("Update") {
                        habitService.updateHabit(habit, name: habitName, goalDays: goalDays)
                        dismiss()
                    }
                    .disabled(habitName.isEmpty)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(habitName.isEmpty ? .gray : .blue)
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text("Current streak: \(habit.streakCount) days")
                        Text("Started on: \(habitService.formattedDate(habit.startDate))")
                    }
                }
            }
            .navigationTitle("Edit Habit")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                }
            )
        }
    }
    
}
