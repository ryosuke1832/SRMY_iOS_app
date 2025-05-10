
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
                            
                            TabBarView(selectedTab: $tabBarSelection)

                        }
                        .ignoresSafeArea(edges: .bottom)
                        .padding(.bottom,0)
                    }
                    .toolbar(.hidden)
                }
            }
        
//        VStack {
//            Text("Personal Settings")
//                .font(.system(size: 30, weight: .heavy, design: .rounded))
//                .padding()
//
//            Form {
//                Section(header: Text("User Info")) {
//                    TextField("Username", text: $username)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//                    
//                    SecureField("Password", text: $password)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//                    
//                    TextField("Age", text: $age)
//                        .keyboardType(.numberPad)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//                    
//                    TextField("Height (cm)", text: $height)
//                        .keyboardType(.decimalPad)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//                    
//                    TextField("Weight (kg)", text: $weight)
//                        .keyboardType(.decimalPad)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//                }
//                
//                if let errorMessage = errorMessage {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                        .padding()
//                }
//
//                Button(action: saveUserData) {
//                    Text("Save")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding()
//            }
//            .padding()
//        }
//        .navigationTitle("Personal Settings")
//    }

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
