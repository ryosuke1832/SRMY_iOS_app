//
//  TabBarView.swift
//  SRMY_iOS_app
//
//  Created on 2025/05/07.
//

import SwiftUI



struct TabBarView: View {
        @Binding var selectedTab: Int
        
        var body: some View {
            HStack(spacing: 0) {
                // Home Tab
                TabBarButton(iconName: "house.fill", title: "Home", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                
                // Log Tab
                TabBarButton(iconName: "list.bullet.clipboard", title: "Log", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                
                // Profile Tab
                TabBarButton(iconName: "person.fill", title: "Profile", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
                
                // Settings Tab
                TabBarButton(iconName: "gear", title: "Settings", isSelected: selectedTab == 3) {
                    selectedTab = 3
                }
            }
            .frame(height: 80)
            .background(
                Rectangle()
                    .fill(Color.white.opacity(0.6))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
                    .edgesIgnoringSafeArea(.bottom)
            )
            .onAppear {

                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                tabBarAppearance.backgroundColor = UIColor.white.withAlphaComponent(0.6)
            }
        }
    }

    struct TabBarButton: View {
        let iconName: String
        let title: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                VStack(spacing: 4) {
                    Image(systemName: iconName)
                        .font(.system(size: 24))
                        .foregroundColor(isSelected ? .blue : .gray)
                    
                    Text(title)
                        .font(.system(size: 12))
                        .foregroundColor(isSelected ? .blue : .gray)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    
