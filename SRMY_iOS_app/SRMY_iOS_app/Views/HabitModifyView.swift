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
        ZStack {
            // Gradient background
            LinearGradient(colors: [.blue, .mint],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer(minLength: 20)

                Text("Set your goals")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(radius: 8)

                Text("Write a list of daily goals you want to achieve")
                    .font(.headline)
                    .foregroundStyle(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Habit list
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(habitService.habits) { habit in
                            EditableHabitRow(habit: habit) {
                                habitService.deleteHabit(habit)
                            }
                        }

                        // Add new habit field
                        HStack(spacing: 12) {
                            TextField("Run for 30 minutes", text: $newHabitName)
                                .padding()
                                .foregroundColor(.white)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                            Button(action: {
                                if !newHabitName.isEmpty {
                                    habitService.addHabit(name: newHabitName)
                                    newHabitName = ""
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                            .disabled(newHabitName.isEmpty)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()

                VStack(spacing: 12) {
                    Button(action: dismiss.callAsFunction) {
                        Text("Confirm")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity)
                            .background(.green.opacity(0.9), in: RoundedRectangle(cornerRadius: 20)
                            )
                    }

                    Button(action: dismiss.callAsFunction) {
                        Text("Cancel")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity)
                            .background(.red.opacity(0.8), in: RoundedRectangle(cornerRadius: 20)
                            )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .multilineTextAlignment(.center)
        }
        .toolbar(.hidden)
    }
}

#Preview {
    let ls = LevelService()
    return HabitModifyView()
        .environmentObject(ls)
        .environmentObject(HabitService(levelService: ls))
}
