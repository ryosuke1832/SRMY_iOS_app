//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/05.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var habitService = HabitService()
    
    var body: some View {
        MainView()
            .environmentObject(habitService)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
