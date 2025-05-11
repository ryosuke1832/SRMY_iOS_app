//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/05.
//

import SwiftUI

struct ContentView: View {
    //@State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("hasAccount")   private var hasAccount   = false
    //@State private var selectedTab = 0
   // @State private var isRegistered: Bool = false
    var body: some View {
        if isLoggedIn {
//            MainContainerView()
            } else {
                Group{

                        LoginView()
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
