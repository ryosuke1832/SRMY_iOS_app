//
//  MainView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var habitService: HabitService
    @State private var showingAddHabit = false
    
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
            .navigationBarItems(trailing: Button(action: {
                showingAddHabit = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddHabit) {
                HabitModifyView()
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(HabitService())
}
