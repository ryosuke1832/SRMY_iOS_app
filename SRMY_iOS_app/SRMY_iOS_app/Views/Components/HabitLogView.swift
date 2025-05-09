//
//  HabitLogView.swift
//  SRMY_iOS_app
//
//  Created by Fabrice Samonte on 9/5/2025.
//

import SwiftUI

struct HabitLogView: View {
    @EnvironmentObject var habitService: HabitService

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(colors: [.blue, .mint],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Custom header text style
                Text("Habit Log")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 3)
                    .padding(.top)

                // Scrollable list of habits
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(habitService.habits) { habit in
                            HabitRowView(habit: habit)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
