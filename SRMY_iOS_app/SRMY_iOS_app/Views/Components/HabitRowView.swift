//
//  HabitRowView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/05.
//



import SwiftUI


struct HabitRowView: View {
    @EnvironmentObject var habitService: HabitService
    @EnvironmentObject var levelService: LevelService
    let habit: Habit
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(habit.name)
                    .font(.headline)
                
                // Streak counter instead of progress bar
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                        .font(.subheadline)
                    
                    Text("\(habit.streakCount) day streak")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            // Status indicator
            if !habitService.isCompletedToday(habit) {
                Button {
                    habitService.markHabitAsCompleted(habit)
                } label: {
                    Image(systemName: "checkmark.circle")
                        .font(.title2)
                        .foregroundColor(.blue)
                        .frame(width: 44, height: 44)
                }
            } else {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
                    .frame(width: 44, height: 44)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5)
        )
    }
}



