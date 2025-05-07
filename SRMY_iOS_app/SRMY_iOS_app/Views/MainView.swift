//
//  MainView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//
import SwiftUI

struct MainView: View {
    @EnvironmentObject var habitService: HabitService
    @EnvironmentObject var levelService: LevelService
    @State private var showingEditHabits = false
    @State private var showingLevelView = false
    @State private var showingLevelUp = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Header area with level indicator and edit button
            HStack {
                Text("My Goals")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Level indicator button
                Button(action: {
                    showingLevelView = true
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.circle.fill")
                            .foregroundColor(.yellow)
                        Text(levelService.levelText)
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.05))
                    )
                }
                
                // Edit button (replacing plus button)
                Button(action: {
                    showingEditHabits = true
                }) {
                    Image(systemName: "pencil.circle.fill")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            
            if habitService.habits.isEmpty {
                // Empty state
                VStack(spacing: 20) {
                    Image(systemName: "list.bullet.clipboard")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                    
                    Text("No Goals Yet")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Tap the edit button to add your goals")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        showingEditHabits = true
                    }) {
                        Text("Add Goals")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.black)
                            )
                    }
                    .padding(.top)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // List of habits
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(habitService.habits) { habit in
                            HabitRowView(habit: habit)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.vertical)
        .navigationBarHidden(true)
        .sheet(isPresented: $showingEditHabits) {
            HabitModifyView()
        }
        .sheet(isPresented: $showingLevelView) {
            LevelView()
                .environmentObject(levelService)
        }
        .sheet(isPresented: $showingLevelUp) {
            LevelUpView(newLevel: levelService.profile.level)
                .environmentObject(levelService)
        }
        .onReceive(levelService.levelUpPublisher) { _ in
            showingLevelUp = true
        }
    }
}



#Preview {
    let ls = LevelService()
    let habits = HabitService(levelService: ls)
    
    // Add some sample habits for preview
//    habits.addHabit(name: "Run for 30 minutes")
//    habits.addHabit(name: "Drink 8 glasses of water")
    
    return MainView()
        .environmentObject(ls)
        .environmentObject(habits)
}
