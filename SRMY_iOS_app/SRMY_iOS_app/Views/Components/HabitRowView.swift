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
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.headline)
                
                Text("\(habit.streakCount)/\(habit.goalDays) days complete")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                ProgressView(value: habitService.progressRatio(for: habit))
                    .progressViewStyle(LinearProgressViewStyle())
            }
            
            Spacer()
            
            if habitService.isGoalAchieved(habit) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            } else if !habitService.isCompletedToday(habit) {
                Button {
                    habitService.markHabitAsCompleted(habit)
                } label: {
                    Image(systemName: "checkmark.circle")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            } else {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
  
    let ls = LevelService()
    HabitListView()
        .environmentObject(ls)
        .environmentObject(HabitService(levelService: ls))
    

}
