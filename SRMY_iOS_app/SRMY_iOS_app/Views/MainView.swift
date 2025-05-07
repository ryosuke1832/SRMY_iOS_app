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
    @State private var showingAddHabit = false
    @State private var showingLevelView = false
    @State private var showingLevelUp   = false
    
    var body: some View {
        NavigationView {
            VStack {
                if habitService.habits.isEmpty {
                   
                    VStack(spacing: 20) {
                        Image(systemName: "list.bullet.clipboard")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("Nothing")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("add new habit!")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    HabitListView()
                }
            }
            .navigationTitle("Habit List")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(trailing: Button(action: {
                showingAddHabit = true
            }) {
                Image(systemName: "plus")
            })
            
            .navigationBarItems(trailing: Button(action: {
                showingLevelView = true
            }) {
                Image(systemName: "star.circle.fill")
            })
            .sheet(isPresented: $showingAddHabit) {
                HabitModifyView()
            }
            .sheet(isPresented: $showingLevelView) {
                  LevelView()
                      .environmentObject(levelService)
              }
              .sheet(isPresented: $showingLevelUp) {         // 🎉 celebration
                  LevelUpView(newLevel: levelService.profile.level)
                      .environmentObject(levelService)
              }
            // -------- listen for level‑up ----------
              .onReceive(levelService.levelUpPublisher) { _ in
                  showingLevelUp = true
              }
        }
        .navigationBarBackButtonHidden(true)
    }
        
}

#Preview {
    let ls = LevelService()
    let habits = HabitService(levelService: ls)
    MainView()
        .environmentObject(ls)
        .environmentObject(habits)
}
        


