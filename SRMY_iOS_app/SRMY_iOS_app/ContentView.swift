//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View { MainView() }
}



#Preview {
    // previews need mock objects too
    let ls = LevelService()
    ContentView()
        .environmentObject(ls)
        .environmentObject(HabitService(levelService: ls))
}
