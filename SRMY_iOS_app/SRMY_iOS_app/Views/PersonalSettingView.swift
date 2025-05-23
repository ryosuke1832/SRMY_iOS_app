
//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI

struct PersonalSettingView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var errorMessage: String? = nil
    @Binding var tabBarSelection: Int

    var body: some View {
        NavigationStack {
                    ZStack {
                        // Background Gradient
                        LinearGradient(colors: [.blue, .mint],
                                       startPoint: .top,
                                       endPoint: .bottom)
                            .ignoresSafeArea()

                        VStack(spacing: 24) {
                            Text("Personal Settings")
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(radius: 10)

                            Group {
                                TextField("Username", text: $username)
                                SecureField("Password", text: $password)
                                TextField("Age", text: $age)
                                    .keyboardType(.numberPad)
                                TextField("Height (cm)", text: $height)
                                    .keyboardType(.decimalPad)
                                TextField("Weight (kg)", text: $weight)
                                    .keyboardType(.decimalPad)
                            }
                            .padding()
                            .background(.white.opacity(0.9))
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .foregroundColor(.black)

                            if let errorMessage = errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                            }

                            Button(action: saveUserData) {
                                Text("Save")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.green.opacity(0.9))
                                    )
                            }
                            .padding(.horizontal)

                            Spacer()

                        }
                        .ignoresSafeArea(edges: .bottom)
                        .padding(.bottom,0)
                    }
                    .toolbar(.hidden)
                    .onAppear {
                                    loadUserData()
                                }
                }
            }
    
    func loadUserData() {
            username = UserDefaults.standard.string(forKey: "username") ?? ""
            password = UserDefaults.standard.string(forKey: "password") ?? ""
            age = UserDefaults.standard.string(forKey: "age") ?? ""
            height = UserDefaults.standard.string(forKey: "height") ?? ""
            weight = UserDefaults.standard.string(forKey: "weight") ?? ""
        }

    // Save user data to UserDefaults
    func saveUserData() {
        // Validate inputs
        guard !username.isEmpty, !password.isEmpty, !age.isEmpty, !height.isEmpty, !weight.isEmpty else {
            errorMessage = "All fields are required."
            return
        }

        // Save to UserDefaults
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(age, forKey: "age")
        UserDefaults.standard.set(height, forKey: "height")
        UserDefaults.standard.set(weight, forKey: "weight")

        errorMessage = nil
    }
}

struct PersonalSettingViewPreview: View {
    @State private var tabBarSelection = 3  // 
    
    var body: some View {
        PersonalSettingView(tabBarSelection: $tabBarSelection)
    }
}

#Preview {
    PersonalSettingViewPreview()
}
