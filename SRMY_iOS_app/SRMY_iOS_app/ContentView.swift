//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/05.
//

import SwiftUI

struct ContentView: View {
    @State private var username: Bool = UserDefaults.standard.bool(forKey: "username")
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    //@State private var selectedTab = 0
    @State private var isRegistered: Bool = false
    var body: some View {
        if isLoggedIn {
            WelcomeView()
            //ProfileView(tabBarSelection: $selectedTab)
            } else {
                Group {
                    if isRegistered {
                        LoginView()
                    } else {
                        AccountRegisterView(onRegisterComplete: {
                            isRegistered = true  // Switch to LoginView
                        })
                    }
                }
            }
        
    }
    
}



#Preview {
    // previews need mock objects too
    let ls = LevelService()
    ContentView()
        .environmentObject(ls)
        .environmentObject(HabitService(levelService: ls))
}
