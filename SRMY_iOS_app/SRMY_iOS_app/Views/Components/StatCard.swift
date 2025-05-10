//
//  StatCard.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/10.
//

import SwiftUI

struct StatCard: View {
    let icon: String
    let title: String
    let value: String
    var iconColor: Color = .blue
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .font(.title2)
                .frame(width: 36, height: 36)
                .background(Color.white.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                
                Text(value)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.blue, .mint],
                      startPoint: .top,
                      endPoint: .bottom)
            .ignoresSafeArea()
        
        VStack(spacing: 16) {
            StatCard(
                icon: "calendar",
                title: "Start Date",
                value: "May 1, 2025"
            )
            
            StatCard(
                icon: "flame.fill",
                title: "Current Streak",
                value: "7 days",
                iconColor: .orange
            )
            
            StatCard(
                icon: "checkmark.circle.fill",
                title: "Last Completed",
                value: "May 10, 2025",
                iconColor: .green
            )
        }
        .padding()
    }
}
