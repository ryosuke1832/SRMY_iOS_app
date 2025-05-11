//
//  ProfileView.swift
//  SRMY_iOS_app
//
//  Created by Yu Lay Ko on 7/5/2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var username: String = ""
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @Binding var tabBarSelection: Int

    var body: some View {
         ZStack {
             // Background gradient
             LinearGradient(colors: [.blue, .mint], startPoint: .top, endPoint: .bottom)
                 .ignoresSafeArea()
             
             VStack(spacing: 20) {
                 // Styled header
                 Text("User Profile")
                     .font(.system(size: 30, weight: .bold, design: .rounded))
                     .foregroundStyle(.white)
                     .shadow(radius: 10)

                 VStack(spacing: 16) {
                     ProfileRow(label: "Username", value: username)
                     ProfileRow(label: "Age", value: age)
                     ProfileRow(label: "Height (cm)", value: height)
                     ProfileRow(label: "Weight (kg)", value: weight)
                 }
                 .padding()
                 .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                 .padding(.horizontal)

                 Spacer().frame(height: 40)
                 
                 Button(action: logoutUser) {
                     Text("Log out")
                         .font(.headline)
                         .padding()
                         .frame(maxWidth: .infinity)
                         .background(Color.red.opacity(0.8))
                         .foregroundColor(.white)
                         .cornerRadius(12)
                 }
                 .padding(.horizontal)
                 .padding(.bottom, 100)
                 
                 Spacer(minLength: 0)
             }
             .ignoresSafeArea(edges: .bottom)
             .multilineTextAlignment(.center)
         }
         .onAppear {
             loadUserData()
         }
         .navigationTitle("")
         .navigationBarHidden(true)
     }


    func loadUserData() {
        username = UserDefaults.standard.string(forKey: "username") ?? "N/A"
        age = UserDefaults.standard.string(forKey: "age") ?? "N/A"
        height = UserDefaults.standard.string(forKey: "height") ?? "N/A"
        weight = UserDefaults.standard.string(forKey: "weight") ?? "N/A"
    }
    
    func logoutUser() {
        let defaults = UserDefaults.standard
        //defaults.removeObject(forKey: "username")
        //defaults.removeObject(forKey: "password")
        defaults.set(false, forKey: "isLoggedIn")
        
        // Optionally redirect to login or welcome view
        //tabBarSelection = 0 // or trigger logout state in your app model
    }
}

struct ProfileRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}




struct ProfileViewPreview: View {
    @State private var tabBarSelection = 2  //
    var body: some View {
        ProfileView(tabBarSelection: $tabBarSelection)
    }
}

#Preview {
    ProfileViewPreview()
}
