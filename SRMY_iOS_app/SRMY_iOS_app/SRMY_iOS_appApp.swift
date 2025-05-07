//
//  SRMY_iOS_appApp.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

@main
struct SRMY_iOS_appApp: App {
    @StateObject private var levelService: LevelService
    @StateObject private var habitService: HabitService


    init() {
        // 2️⃣  One concrete instance that both wrappers can share
        let coreLevelService = LevelService()

        _levelService = StateObject(wrappedValue: coreLevelService)
        _habitService = StateObject(
            wrappedValue: HabitService(levelService: coreLevelService)
        )
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(levelService)
                .environmentObject(habitService)
        }
    }
}

