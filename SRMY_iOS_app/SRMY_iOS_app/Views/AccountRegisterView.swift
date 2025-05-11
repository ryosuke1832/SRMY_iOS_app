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
        ZStack {
            // Gradient background
            LinearGradient(colors: [.blue, .mint],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Text("Register Account")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(radius: 8)

                Text("Create an account to get started")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Group {
                    TextField("Username", text: $username)
                        .padding()
                        .foregroundColor(.white)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                        .autocapitalization(.none)
                        .disableAutocorrection(true)

                    SecureField("Password", text: $password)
                        .padding()
                        .foregroundColor(.white)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .foregroundColor(.white)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Button(action: registerUser) {
                    Text("Register")
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(.green.opacity(0.9), in: RoundedRectangle(cornerRadius: 20))
                }
                .padding(.horizontal)

                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(.bottom, 30)
        }
        .toolbar(.hidden)
    }

    // MARK: - Register Logic
    private func registerUser() {
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
        onRegisterComplete()  // Switch to LoginView or next step
    }
}

#Preview {
    AccountRegisterView{
        
    }
}
