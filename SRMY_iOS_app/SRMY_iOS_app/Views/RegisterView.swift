//
//  RegisterView.swift
//  SRMY_iOS_app
//
//  Created by Lora on 2025/5/11.
//

import SwiftUI

struct RegisterView: View {
    // MARK: ‑‑ State
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?
    @State private var didRegister = false        // drives navigation
    @AppStorage("hasAccount") private var hasAccount = false
    var body: some View {
 
            ZStack {
                // Background
                LinearGradient(colors: [.blue, .mint],
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    Text("Create Account")
                        .font(.system(size: 34, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 10)

                    Group {
                        TextField("Username", text: $username)
                            .padding()
                            .background(.white.opacity(0.9))
                            .cornerRadius(12)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(.white.opacity(0.9))
                            .cornerRadius(12)

                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(.white.opacity(0.9))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    Button(action: register) {
                        Text("Register")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity)
                            .background(.green.opacity(0.9), in: Capsule())
                    }
                    .padding(.horizontal)

                    // Hidden nav‑link triggers when didRegister flips true
                    NavigationLink(destination: WelcomeView(),
                                   isActive: $didRegister) { EmptyView() }

                    Spacer()
                }
                .padding(.bottom, 30)
                .multilineTextAlignment(.center)
            }
            .toolbar(.hidden)
        
    }

    // MARK: ‑‑ Helpers
    private func register() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are required."
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }

        // Persist new creds
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")

        errorMessage = nil
        hasAccount  = true                    // mark that this device has an account
        didRegister = true               // jump to WelcomeView
    }
}

#Preview { RegisterView() }
