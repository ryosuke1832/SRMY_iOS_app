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
    @State private var didLogin = false
    @State private var errorMessage: String? = nil
    @StateObject private var authService = AuthService()

    var body: some View {
   
            ZStack {
                // Gradient Background
                LinearGradient(colors: [.blue, .mint],
                               startPoint: .top,
                               endPoint: .bottom)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    Text("Manual Login")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
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
                    }
                    .padding(.horizontal)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    Button(action: {
                        loginUser()
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.green.opacity(0.9), in: RoundedRectangle(cornerRadius: 20)
                            )
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: WelcomeView(), isActive: $didLogin) {
                        EmptyView()
                    }

                    Spacer()
                }
                .padding(.bottom)
            }
            .toolbar(.hidden)
        }

    

    func loginUser() {
        AuthService.shared.loginWithUsernamePassword(username: username, password: password) { success, message in
            if success {
                didLogin = true
                errorMessage = nil
               // UserDefaults.standard.set(true, forKey: "isLoggedIn")
                // send notification
                NotificationCenter.default.post(name: NSNotification.Name("LoggedIn"), object: nil)
            } else {
                errorMessage = message
            }
        }
    }
}

#Preview {
    ManualLogin()
}


//import SwiftUI
//
//struct ManualLogin: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var isLoggedIn = false
//    @State private var errorMessage: String? = nil
//    @StateObject private var authService = AuthService()
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Manual Login")
//                    .font(.largeTitle)
//                    .padding()
//
//                TextField("Username", text: $username)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .autocapitalization(.none)
//                    .padding()
//
//                SecureField("Password", text: $password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//
//                if let errorMessage = errorMessage {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                        .padding()
//                }
//
//                Button(action: {
//                    loginUser()
//                }) {
//                    Text("Login")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding()
//
//                // Hidden NavigationLink to trigger programmatic navigation
//                NavigationLink(destination: WelcomeView(), isActive: $isLoggedIn) {
//                    EmptyView()
//                }
//                
//                Spacer()
//                    
//            }
//            .padding()
//        }
//        .navigationBarBackButtonHidden(true)
//    
//    }
//
//    func loginUser() {
//        AuthService.shared.loginWithUsernamePassword(username: username, password: password) { success, message in
//            if success {
//                isLoggedIn = true
//                errorMessage = nil
//            } else {
//                errorMessage = message
//            }
//        }
//    }
//}
//
//#Preview {
//    ManualLogin()
//}
