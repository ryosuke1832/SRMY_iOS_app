//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

struct WelcomeView: View {
    @State private var username: String = ""
    @State private var navigateToMain = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Hello, \(username)!")
                    .font(.title2)
                    .foregroundColor(.blue)

                Text("Tap anywhere to continue")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle()) // Makes the entire VStack tappable
            .onTapGesture {
                navigateToMain = true
            }
            .onAppear {
                username = UserDefaults.standard.string(forKey: "username") ?? "Guest"
            }
            .background(
                NavigationLink(destination: MainView(), isActive: $navigateToMain) {
                    EmptyView()
                }
                .hidden()
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WelcomeView()
}




