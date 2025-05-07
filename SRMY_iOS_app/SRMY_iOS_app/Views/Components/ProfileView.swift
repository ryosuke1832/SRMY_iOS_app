//
//  ProfileView.swift
//  SRMY_iOS_app
//
//  Created by Yu Lay Ko on 7/5/2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var username: String = ""
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("User Profile")
                .font(.largeTitle)
                .padding(.top)

            Form {
                Section(header: Text("User Info")) {
                    ProfileRow(label: "Username", value: username)
                    ProfileRow(label: "Age", value: age)
                    ProfileRow(label: "Height (cm)", value: height)
                    ProfileRow(label: "Weight (kg)", value: weight)
                }
            }
        }
        .onAppear(perform: loadUserData)
        .navigationTitle("Profile")
    }

    func loadUserData() {
        username = UserDefaults.standard.string(forKey: "username") ?? "N/A"
        age = UserDefaults.standard.string(forKey: "age") ?? "N/A"
        height = UserDefaults.standard.string(forKey: "height") ?? "N/A"
        weight = UserDefaults.standard.string(forKey: "weight") ?? "N/A"
    }
}

struct ProfileRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

