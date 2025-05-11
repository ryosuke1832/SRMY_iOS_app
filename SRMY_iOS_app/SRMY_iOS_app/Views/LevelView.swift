
//
//  ContentView.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import SwiftUI
import ConfettiSwiftUI

struct LevelView: View {
    @State private var confettiCounter = 0
    @EnvironmentObject var levelService: LevelService
    #if DEBUG
    /// Test‑only probe so unit‑tests can read the value
    var _test_confettiCounter: Int { confettiCounter }
    #endif
    // Convenience computed progress in 0‒1 range
    private var progress: Double {
        Double(levelService.profile.xp) /
        Double(levelService.xpNeeded(for: levelService.profile.level))
    }
    
//    @State private var isSpinning = false
    @State private var rotationAngle: Double = 0

        
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(colors: [.blue, .mint],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            VStack {
                Text(levelService.levelText).font(.title2).bold()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .scaleEffect(1.2)
                
//                ProgressView(value: levelService.progress)
//                    .frame(height: 12).tint(.green)
                
                Image("level\(levelService.profile.level)")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .rotation3DEffect(
                            .degrees(rotationAngle),
                            axis: (x: 0, y: 1, z: 0)
                        )
                    .onAppear {
                                // Spin once on appear
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    rotationAngle += 360
                                }
                    }
                    .onTapGesture {
                        // Spin again each tap
                        withAnimation(.easeInOut(duration: 1.0)) {
                            rotationAngle += 360
                        }
                    }
                
                Text("Noble Novice").font(.title2).bold()
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .scaleEffect(1.2)

            }
            .padding()
            .onReceive(levelService.levelUpPublisher) { _ in   // still celebrate
                confettiCounter += 1
            }
            .confettiCannon(trigger: $confettiCounter)
        }
    }
}

#Preview {
    LevelView()
        .environmentObject(LevelService())
}
