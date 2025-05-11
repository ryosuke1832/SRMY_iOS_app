//
//  LoginFlow.swift
//  SRMY_iOS_app
//
//  Created by Lora on 2025/5/11.
//
import SwiftUI

struct LoginFlow: View {
    @AppStorage("hasAccount") private var hasAccount = false

    var body: some View {
        NavigationStack {
            LoginView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .manualLogin:  ManualLogin()
                    case .register:     RegisterView()
                    case .welcome:      WelcomeView()
                    }
                }
        }
    }

    enum Route: Hashable { case manualLogin, register, welcome }
}
