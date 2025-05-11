////
////  RootTabContainer.swift
////  SRMY_iOS_app
////
////  Created by Lora on 2025/5/11.
////
//
import SwiftUI


struct RootTabContainer: View {
    @State private var selectedTab = 0
    @EnvironmentObject var levelService: LevelService
    @EnvironmentObject var habitService: HabitService

    var body: some View {
        ZStack {
            currentTab                           // ① chosen screen
            VStack { Spacer();
            TabBarView(selectedTab: $selectedTab)
                .background(
                 Rectangle()
                    .fill(Color.white.opacity(0.6))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
            )

            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    // ② result‑builder gives each branch its own concrete type
    @ViewBuilder
    private var currentTab: some View {
        switch selectedTab {
        case 0: MainView(selectedTab: $selectedTab)
        case 1: LogView(tabBarSelection: $selectedTab)
        case 2: ProfileView(tabBarSelection: $selectedTab)
        case 3:PersonalSettingView(tabBarSelection: $selectedTab)
        default:MainView(selectedTab: $selectedTab)
        }
    }
}

