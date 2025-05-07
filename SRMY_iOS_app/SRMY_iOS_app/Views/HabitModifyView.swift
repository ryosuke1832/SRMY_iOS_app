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
    
    // List of habits being edited
    @State private var editableHabits: [Habit] = []
    @State private var newHabitName: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Set Your Goals")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Write a list of daily goals you want to achieve")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.bottom, 5)
            
            // List of existing habits
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(habitService.habits) { habit in
                        EditableHabitRow(habit: habit, onDelete: {
                            habitService.deleteHabit(habit)
                        })
                    }
                    
                    // Add new habit field
                    HStack {
                        TextField("Run for 30 minutes", text: $newHabitName)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 2)
                            )
                        
                        Button(action: {
                            if !newHabitName.isEmpty {
                                habitService.addHabit(name: newHabitName)
                                newHabitName = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.black)
                                .font(.title2)
                        }
                        .disabled(newHabitName.isEmpty)
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            VStack(spacing: 12) {
                // Confirm button
                Button(action: {
                    dismiss()
                }) {
                    Text("Confirm")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.black)
                        )
                }
                
                // Cancel button
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.red)
                        )
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}


#Preview {
    let ls = LevelService()
    return HabitModifyView()
        .environmentObject(ls)
        .environmentObject(HabitService(levelService: ls))
}
