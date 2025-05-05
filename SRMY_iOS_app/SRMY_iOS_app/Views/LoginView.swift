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
                        onCompletion: handleAuth
                    )
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    .padding()

                    GoogleSignInButton(action: handleSignInButton)
                        .frame(height: 50)
                        .padding()

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

    func handleSignInButton() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("Unable to get rootViewController")
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                print("Google Sign-In failed: \(error.localizedDescription)")
                return
            }

            guard let user = signInResult?.user else {
                print("No user found in Google Sign-In result.")
                return
            }

            print("✅ Signed in as: \(user.profile?.email ?? "")")
            print("Name: \(user.profile?.name ?? "")")
            isLoggedIn = true
        }
    }

    func handleAuth(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            if let credential = auth.credential as? ASAuthorizationAppleIDCredential {
                userIdentifier = credential.user
                UserDefaults.standard.set(userIdentifier, forKey: "apple_user_id")

                if let name = credential.fullName?.givenName {
                    print("Full Name: \(name)")
                }
                if let email = credential.email {
                    print("Email: \(email)")
                }

                isLoggedIn = true
            }
        case .failure(let error):
            print("Authorization failed: \(error.localizedDescription)")
        }
    }
}

