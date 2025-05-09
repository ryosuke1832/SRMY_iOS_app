//
//  TabBarView.swift
//  SRMY_iOS_app
//
//  Created on 2025/05/07.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var levelService: LevelService
    @EnvironmentObject var habitService: HabitService
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home screen
            MainView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            // Log screen (Habit recording)
            HabitLogView()
                .tabItem {
                    Label("Log", systemImage: "list.bullet.clipboard")
                }
                .tag(1)
            
            // Profile screen
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(2)
            
            // Settings screen
            PersonalSettingView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(3)
        }
        .environmentObject(levelService)
        .environmentObject(habitService)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor.white.withAlphaComponent(0.6)

            UITabBar.appearance().standardAppearance = tabBarAppearance
            if #available(iOS 16.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
}

#Preview {
    let levelService = LevelService()
    let habitService = HabitService(levelService: levelService)
    
    return TabBarView()
        .environmentObject(levelService)
        .environmentObject(habitService)
}

