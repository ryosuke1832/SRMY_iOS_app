//
//  habitManager.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import Foundation
import AuthenticationServices
import GoogleSignIn

@MainActor
class AuthService: ObservableObject {
    
    static let shared = AuthService()
    
    
    
    func handleAppleLogin(result: Result<ASAuthorization, Error>, completion: @escaping (Bool) -> Void) {
            switch result {
            case .success(let auth):
                if let credential = auth.credential as? ASAuthorizationAppleIDCredential {
                    let userIdentifier = credential.user
                    UserDefaults.standard.set(userIdentifier, forKey: "apple_user_id")
                    
                    if let name = credential.fullName?.givenName {
                        print("Apple User Name: \(name)")
                    }
                    if let email = credential.email {
                        print("Apple Email: \(email)")
                    }
                    
                    completion(true)
                } else {
                    completion(false)
                }

            case .failure(let error):
                print("Apple login failed: \(error.localizedDescription)")
                completion(false)
            }
        }

        func handleGoogleLogin(presentingViewController: UIViewController, completion: @escaping (Bool) -> Void) {
            GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
                if let error = error {
                    print("Google login failed: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                guard let user = signInResult?.user else {
                    completion(false)
                    return
                }

                print("Google Email: \(user.profile?.email ?? "N/A")")
                print("Google Name: \(user.profile?.name ?? "N/A")")

                completion(true)
            }
        }
    
    func loginWithUsernamePassword(username: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        guard !username.isEmpty, !password.isEmpty else {
            completion(false, "Username and Password cannot be empty")
            return
        }

        // Simple hardcoded credentials check (you could later connect this to a backend or Firebase)
        if username == "Admin" && password == "password123" {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            completion(true, nil)
        } else {
            completion(false, "Invalid credentials")
        }
    }
    
}
