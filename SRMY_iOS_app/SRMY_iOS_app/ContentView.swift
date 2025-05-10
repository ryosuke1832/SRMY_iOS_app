//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/05.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    var body: some View {
        if isLoggedIn {
            WelcomeView()
            } else {
                    LoginView()
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
