//
//  LevelUpView.swift
//  SRMY_iOS_app
//
//  Created by Lora on 2025/5/7.
//

import SwiftUI
import ConfettiSwiftUI        // already in the project
// import Lottie               // uncomment if you use a .json badge animation

/// A full‑screen celebration shown once per multi‑level jump.
///
/// Present with `.sheet(isPresented:)` or `.fullScreenCover`.
struct LevelUpView: View {
    let newLevel: Int
    
    // internal
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var levelService: LevelService
    @State private var confetti = 0
    
    var body: some View {
        ZStack {
            // MARK: ‑‑ Color + subtle vignette background
            LinearGradient(
                colors: [Color.indigo.opacity(0.8), Color.purple.opacity(0.9)],
                startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            // MARK: ‑‑ Content
            VStack(spacing: 32) {
                Spacer()
                
                // optional Lottie badge
//                LottieView(name: "level_badge", loopMode: .playOnce)
//                    .frame(width: 180, height: 180)
                
                // level number text
                Text("Level \(newLevel)!")
                    .font(.system(size: 56, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                    .scaleEffect(1.2)            // little pop
                    .animation(.spring(), value: newLevel)
                
                Text("Awesome work 🎉")
                    .font(.title3.weight(.medium))
                    .foregroundStyle(.white.opacity(0.9))
                
                Spacer()
                
                Button(action: dismiss.callAsFunction) {
                    Text("Continue")
                        .font(.headline.bold())
                        .padding(.horizontal, 40)
                        .padding(.vertical, 14)
                        .background(.ultraThinMaterial, in: Capsule())
                }
                .accessibilityIdentifier("continueLevelUp")
                .padding(.bottom, 40)
            }
            .multilineTextAlignment(.center)
            
            // MARK: ‑‑ Confetti burst
            Color.clear                                  // attach to invisible view
                .confettiCannon(trigger: $confetti,
                                num: 40,  // pieces
                                confettis: [.text("⭐️"), .shape(.triangle), .shape(.circle)],
                                colors: [.yellow, .white, .orange])
        }
        .onAppear {
            confetti += 1
            giveHapticFeedback()
        }
    }
    
    // MARK: ‑‑ Helpers
    private func giveHapticFeedback() {
#if os(iOS)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
#endif
    }
}

#Preview {
    LevelUpView(newLevel: 7)
}
