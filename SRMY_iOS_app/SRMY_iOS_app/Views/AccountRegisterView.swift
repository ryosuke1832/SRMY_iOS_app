//
//  AccountRegisterView.swift
//  SRMY_iOS_app
//
//  Created by Yu Lay Ko on 11/5/2025.
//

import SwiftUI

struct AccountRegisterView: View {
    var onRegisterComplete: () -> Void

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Register Account")
                .font(.largeTitle)
                .bold()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Button("Register") {
                registerUser()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
    }

    func registerUser() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        // Save user data
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")

        errorMessage = nil
        onRegisterComplete()  // Switch to LoginView
    }
}

