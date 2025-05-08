//
//  LevelUpView.swift
//  SRMY_iOS_app
//
//  Created by Lora on 2025/5/7.
//

import SwiftUI
import ConfettiSwiftUI        // already in the project


/// A random gradiant pattern full‑screen celebration shown once per multi‑level jump.
///

private struct Palette {
    let gradient: [Color]     // background
    let confetti: [Color]     // matching confetti pieces
    let emojis:  [String]     // optional custom confetti emoji

    static let all: [Palette] = [
        .init(
            gradient: [.indigo, .purple],
            confetti: [.yellow, .white, .orange],
            emojis:  ["⭐️"]
        ),
        .init(
            gradient: [.blue, .mint],
            confetti: [.white, .cyan, .mint],
            emojis:  ["💎","🌀"]
        ),
        .init(
            gradient: [.pink, .red],
            confetti: [.white, .pink, .red],
            emojis:  ["❤️","🌸"]
        ),
        .init(
            gradient: [.orange, .yellow],
            confetti: [.orange, .yellow, .white],
            emojis:  ["🔥","✨"]
        ),
        .init(
            gradient: [.teal, .black],
            confetti: [.teal, .white, .gray],
            emojis:  ["🚀","🪐"]
        )
    ]
}

struct LevelUpView: View {
    let newLevel: Int
    
    // internal
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var levelService: LevelService
    @State private var confetti = 0
    @State private var palette = Palette.all.randomElement()!
    var body: some View {
        ZStack {
            // MARK: ‑‑ Random color from palette
            LinearGradient(
                colors: palette.gradient,
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()
            AngularGradient(gradient: Gradient(colors: palette.gradient),
                            center: .center)
                .blendMode(.overlay)
                .opacity(0.3)
                .rotationEffect(.degrees(confetti == 0 ? 0 : 360))
                .animation(.linear(duration: 8).repeatForever(autoreverses: false),
                           value: confetti)

            // MARK: ‑‑ Content
            VStack(spacing: 32) {
                Spacer()
                                
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
                        .foregroundColor(.white)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity)
                        .background(.green.opacity(0.9), in: RoundedRectangle(cornerRadius: 20)
                        )
                        .padding()
                }
                .accessibilityIdentifier("continueLevelUp")
                .padding(.bottom, 40)
            }
            .multilineTextAlignment(.center)
            
            // MARK: ‑‑ Confetti burst
            Color.clear
                .confettiCannon(trigger: $confetti,
                                num: 40,
                                confettis: palette.emojis.map { .text($0) } +
                                           [.shape(.triangle), .shape(.circle)],
                                colors: palette.confetti)

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
    LevelUpView(newLevel: 2)
}
