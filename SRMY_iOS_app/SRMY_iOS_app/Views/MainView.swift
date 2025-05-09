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
        ZStack {
            // Background Gradient
            LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Header area with level indicator and edit button
                HStack {
                    Text("My Goals")
                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()

                    Button(action: {
                        showingLevelView = true
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "star.circle.fill")
                                .foregroundColor(.yellow)
                            Text(levelService.levelText)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.2))
                        )
                    }

                    Button(action: {
                        showingEditHabits = true
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal)

                    if habitService.habits.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "list.bullet.clipboard")
                                .font(.system(size: 60))
                                .foregroundColor(.white.opacity(0.7))

                            Text("No Goals Yet")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)

                            Text("Tap the edit button to add your goals")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)

                            Button(action: {
                                showingEditHabits = true
                            }) {
                                Text("Add Goals")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white.opacity(0.9))
                                    )
                                }
                                .padding(.top)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(habitService.habits) { habit in
                                    HabitRowView(habit: habit)
                                        .id(habit.id)
                                        .transition(
                                            AnyTransition.scale(scale: 0.6)
                                                .combined(with: .opacity)
                                                .animation(.easeInOut(duration: 0.4))
                                        )
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
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
        habits.addHabit(name: "Run for 30 minutes")
        habits.addHabit(name: "Drink 8 glasses of water")
    
    return MainView()
        .environmentObject(ls)
        .environmentObject(habits)
}
