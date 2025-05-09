//
//  EditableHabitRow.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/07.
//

import SwiftUI

struct EditableHabitRow: View {
    let habit: Habit
    var onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 2)
            )
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color.white.opacity(0.9))
                    )
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    let sampleHabit = Habit(name: "Drink Water")
    EditableHabitRow(habit: sampleHabit, onDelete: {})
}

