//
//  ManualLogin.swift
//  SRMY_iOS_app
//
//  Created by Yu Lay Ko on 5/5/2025.
//

import SwiftUI

struct ManualLogin: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            VStack {
                Text("Manual Login")
                    .font(.largeTitle)
                    .padding()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }

                Button(action: {
                    loginUser()
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // Hidden NavigationLink to trigger programmatic navigation
                NavigationLink(destination: MainView(), isActive: $isLoggedIn) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
        }
    }

    func loginUser() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Username and Password cannot be empty"
            return
        }

        if username == "Admin" && password == "password123" {
            isLoggedIn = true
            errorMessage = nil
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
        } else {
            errorMessage = "Invalid credentials"
        }
    }
}
