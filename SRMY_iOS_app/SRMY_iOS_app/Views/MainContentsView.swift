//
//  MainContentsView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/11.
//

import SwiftUI
struct MainContainerView: View {
    @State private var selectedTab = 0
    @StateObject private var levelService = LevelService()
    @StateObject private var habitService: HabitService
    
    init() {
        let ls = LevelService()
        self._levelService = StateObject(wrappedValue: ls)
        self._habitService = StateObject(wrappedValue: HabitService(levelService: ls))
    }
    
    var body: some View {
        ZStack {

            if selectedTab == 0 {
                MainView(selectedTab: $selectedTab)
                    .environmentObject(levelService)
                    .environmentObject(habitService)
            } else if selectedTab == 1 {
                LogView(tabBarSelection: $selectedTab)
                    .environmentObject(levelService)
                    .environmentObject(habitService)
            } else if selectedTab == 2 {
                ProfileView(tabBarSelection: $selectedTab)
                    .environmentObject(levelService)
                    .environmentObject(habitService)
            } else if selectedTab == 3 {
                PersonalSettingView(tabBarSelection: $selectedTab)
                    .environmentObject(levelService)
                    .environmentObject(habitService)
            }
            
            VStack {
                Spacer()
                TabBarView(selectedTab: $selectedTab)
                    .background(
                        Rectangle()
                            .fill(Color.white.opacity(0.6))
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
                    )
            }
        }
        .ignoresSafeArea(edges: .bottom) 
    }
}
