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
    @StateObject private var authService = AuthService()

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
        .navigationBarBackButtonHidden(true)
    
    }

    func loginUser() {
        AuthService.shared.loginWithUsernamePassword(username: username, password: password) { success, message in
            if success {
                isLoggedIn = true
                errorMessage = nil
            } else {
                errorMessage = message
            }
        }
    }
}
