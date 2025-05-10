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
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(colors: [.blue, .mint],
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    if isLoggedIn {
                        Text("Welcome, Apple or Google User!")
                            .font(.title3.weight(.medium))
                            .foregroundStyle(.white)
                            .padding()
                    } else {
                        Text("Welcome, Go Getter")
                            .font(.system(size: 34, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(radius: 10)

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
                        .clipShape(Capsule())
                        .padding(.horizontal)

                        Button(action: {
                            if let rootVC = UIApplication.shared.connectedScenes
                                .compactMap({ ($0 as? UIWindowScene)?.keyWindow?.rootViewController })
                                .first {
                                AuthService.shared.handleGoogleLogin(presentingViewController: rootVC) { success in
                                    isLoggedIn = success
                                }
                            }
                        }) {
                            HStack {
                                Image(systemName: "globe")
                                Text("Sign in with Google")
                                    .bold()
                            }
                            .foregroundColor(.black)
                            .padding(.vertical, 14)
                            .frame(maxWidth: .infinity)
                            .background(.white.opacity(0.9), in: RoundedRectangle(cornerRadius: 30)
                            )
                        }
                        .padding(.horizontal)

                        NavigationLink(destination: ManualLogin()) {
                            Text("New User Login")
                                .foregroundColor(.white)
                                .padding(.vertical, 14)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial, in: Capsule())
                        }
                        .padding(.horizontal)
                    }

                    Spacer()

                    // Auto-navigation to MainView after login
                    NavigationLink(destination: MainView(selectedTab: .constant(0)), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                }
                .padding(.bottom, 30)
                .multilineTextAlignment(.center)
            }
            .toolbar(.hidden)
        }
    }
}

#Preview {
    LoginView()
}

