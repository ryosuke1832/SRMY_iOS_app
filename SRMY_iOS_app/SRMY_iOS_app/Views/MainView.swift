//
//  MainView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

struct MainView: View {
    @StateObject private var habitService = HabitService()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitService.habits) { habit in
                    HabitListView(habit: habit, habitService: habitService)
                }
            }
            .navigationTitle("Habits")
        }
    }
}

#Preview {
    MainView()
}
