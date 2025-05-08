//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HabitModifyView()
                .tabItem() {
                    Image("settings-white")
                    Text("Settings")
                }
            PersonalSettingView()
                .badge(10)
                .tabItem() {
                    Image("user-white")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    TabBarView()
}
