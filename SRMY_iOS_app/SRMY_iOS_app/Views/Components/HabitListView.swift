//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

// Individual habit List
struct HabitListView: View {
    @EnvironmentObject var habitService: HabitService
    @State private var editingHabit: Habit? = nil
    
    var body: some View {
        List {
            ForEach(habitService.habits) { habit in
                HabitRowView(habit: habit)
                    .swipeActions (edge: .leading, allowsFullSwipe: false){
                        Button(role: .destructive) {
                            habitService.deleteHabit(habit)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            editingHabit = habit
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                
            }
            .sheet(item: $editingHabit) { habit in
                HabitEditView(habit: habit)
            }
        }
    }
}


