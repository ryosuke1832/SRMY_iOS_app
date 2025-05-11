//
//  HabitLogRow.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/10.
//

import SwiftUI

struct HabitLogRow: View {
    let habit: Habit
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(habit.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Streak: \(habit.streakCount) days")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.title2)
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(12)
    }
}
