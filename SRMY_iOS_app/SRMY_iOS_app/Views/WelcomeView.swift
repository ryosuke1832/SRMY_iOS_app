//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

struct WelcomeView: View {
    @State private var username: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Hello, \(username)!")
                .font(.title2)
                .foregroundColor(.blue)

            Spacer()
        }
        .padding()
        .onAppear(perform: loadUsername)
    }

    func loadUsername() {
        username = UserDefaults.standard.string(forKey: "username") ?? "Guest"
    }
}


