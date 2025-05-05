//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//



import SwiftUI

struct HabitModifyView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var habitService: HabitService
    
    @State private var habitName: String = ""
    @State private var goalDays: Int = 21
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("habit")) {
                    TextField("name", text: $habitName)
                    
                    Stepper(value: $goalDays, in: 1...365) {
                        HStack {
                            Text("Goal")
                            Spacer()
                            Text("\(goalDays)days")
                        }
                    }
                }
                
                Section {
                    Button("Create") {
                        habitService.addHabit(name: habitName, goalDays: goalDays)
                        dismiss()
                    }
                    .disabled(habitName.isEmpty)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(habitName.isEmpty ? .gray : .blue)
                }
            }
            .navigationTitle("new Habit")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                }
            )
        }
    }
}
