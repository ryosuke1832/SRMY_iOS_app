//
//  HabitDetailView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/10.
//

import SwiftUI


// Habit detail view
struct HabitDetailView: View {
    let habit: Habit
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var habitService: HabitService
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .mint],
                          startPoint: .top,
                          endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding()
                    
                    Spacer()
                }
                
                Text(habit.name)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                // Habit statistics
                VStack(spacing: 16) {
                    StatCard(
                        icon: "calendar",
                        title: "Start Date",
                        value: formatDate(habit.startDate)
                    )
                    
                    StatCard(
                        icon: "flame.fill",
                        title: "Current Streak",
                        value: "\(habit.streakCount) days",
                        iconColor: .orange
                    )
                    
                    if let lastDate = habit.lastCompletedDate {
                        StatCard(
                            icon: "checkmark.circle.fill",
                            title: "Last Completed",
                            value: formatDate(lastDate),
                            iconColor: .green
                        )
                    }
                }
                .padding()
                
                // Mock graph display
                VStack(alignment: .leading) {
                    Text("Completion History")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    
                    // graph
                    HStack(alignment: .bottom, spacing: 8) {
                        let history = habitService.completionHistoryForLast(days: 7, for: habit)
                        ForEach(0..<7, id: \.self) { i in
                            let completed = history[i]
                            let height: CGFloat = completed ? 120 : 40
                            
                            Rectangle()
                                .fill(completed ? Color.green : Color.gray.opacity(0.3))
                                .frame(height: height)
                                .frame(width: 30)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Text("Past 7 days")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
    
    func colorForDay(_ day: Int) -> Color {
        let completed = day % 3 == 0  // Mock data
        return completed ? Color.green : Color.gray.opacity(0.3)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

#Preview("Habit Detail View") {
    var habit = Habit(name: "Running", startDate: Date().addingTimeInterval(-60*60*24*14))
    habit.streakCount = 7
    habit.lastCompletedDate = Date()
    
    return HabitDetailView(habit: habit)
}
