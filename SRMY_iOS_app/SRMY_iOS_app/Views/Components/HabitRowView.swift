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
    
    @State private var showXPGain = false
    @State private var lastGain   = 0
    
    var body: some View {
            ZStack {
                // Gradient background for card
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)

                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(habit.name)
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.primary)

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

                    // Completion button or filled icon with XP gain
                    if !habitService.isCompletedToday(habit) {
                        Button {
                            habitService.markHabitAsCompleted(habit)
                        withAnimation {
                            habitService.completeHabitWithDelay(habit)
                                }
                            
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .frame(width: 44, height: 44)
                        }
                        .buttonStyle(.plain)
                    } else {
                        ZStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.green)
                                .frame(width: 44, height: 44)

                            if showXPGain {
                                Text("+\(lastGain)")
                                    .font(.caption.bold())
                                    .foregroundStyle(.green)
                                    .offset(y: -30)
                                    .transition(.opacity.combined(with: .offset(y: -10)))
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.vertical, 4)
            .onReceive(levelService.xpAwardedPublisher) { event in
                guard event.habitID == habit.id else { return }
                lastGain = event.amount
                withAnimation(.spring()) {
                    showXPGain = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeOut) {
                        showXPGain = false
                    }
                }
            }
        }
}

#Preview {
    let levelService = LevelService()
    let habitService = HabitService(levelService: levelService)
    
    // Sample Habit
    let sampleHabit = Habit(name: "Read 10 pages")
    
    return HabitRowView(habit: sampleHabit)
        .environmentObject(levelService)
        .environmentObject(habitService)
}




