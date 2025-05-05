//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @State private var userIdentifier: String = ""
    @State private var isLoggedIn = false
    @StateObject private var authService = AuthService()

    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    Text("Welcome, Apple or Google User!")
                        .font(.headline)
                        .padding()
                } else {
                    SignInWithAppleButton(
                        .signIn,
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            AuthService.shared.handleAppleLogin(result: result) { success in
                                isLoggedIn = success
                            }
                        }
                    )
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    .padding()

                    Button("Sign in with Google") {
                                        if let rootVC = UIApplication.shared.connectedScenes
                                            .compactMap({ ($0 as? UIWindowScene)?.keyWindow?.rootViewController })
                                            .first {
                                            AuthService.shared.handleGoogleLogin(presentingViewController: rootVC) { success in
                                                isLoggedIn = success
                                            }
                                        }
                                    }
                                    .frame(height: 50)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)

                    NavigationLink(destination: ManualLogin()) {
                        Text("Manual Login")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }

                // Auto-navigation to MainView after login
                NavigationLink(destination: MainView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .navigationTitle("Login")
        }
    }

    
}

