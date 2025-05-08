//
//  LevelService.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//
//Every habit will provide 25 XP(at least) when it's checked. Base can be changed in HabitService
//(optional) unlock more slots as the level got higher?
import Foundation
import SwiftUI
import Combine



protocol LevelServiceProtocol: ObservableObject {
    var profile: UserProfile { get }// current XP & level
    var levelText: String { get }
    var progress: Double { get }
    var levelUpPublisher: AnyPublisher<Int,Never> { get }
    

    func xpNeeded(for level: Int) -> Int
    func awardXP(habitID:UUID, base: Int, comboIndex: Int, streak: Int)                    // comboIndex: 0,1,2…
}

final class LevelService: LevelServiceProtocol {
    @Published private(set) var profile = UserProfile(name: "Player")        //can be replaced with real username
    

    
    private let levelUpSubject = PassthroughSubject<Int,Never>()
    var levelUpPublisher: AnyPublisher<Int,Never> { levelUpSubject.eraseToAnyPublisher() }

    var levelText: String { "Level \(profile.level)" }                      //helper strings the UI can reuse
    var progress: Double {
        Double(profile.xp) / Double(xpNeeded(for: profile.level))
    }
    
    // simple curve: 50, 75, 100 XP…
    func xpNeeded(for level: Int) -> Int { 50 + 25 * (level - 1) }
    struct XPGainEvent { let habitID: UUID; let amount: Int }
    let xpAwardedPublisher = PassthroughSubject<XPGainEvent,Never>()

    func awardXP(habitID:UUID, base: Int, comboIndex: Int, streak: Int) {
        let comboMult  = 1.0 + 0.25 * Double(comboIndex)                       // 1×, 1.2×, 1.4×…
        let streakMult = streakMultiplier(for: streak)                         // from HabitService
        let gained     = Int(Double(base) * comboMult * streakMult)
        profile.xp += gained
        var levelsGained = 0
        while profile.xp >= xpNeeded(for: profile.level) {
            profile.xp -= xpNeeded(for: profile.level)
            profile.level += 1
            levelsGained += 1
        }
        if levelsGained > 0 {
            levelUpSubject.send(levelsGained)                  // fire once
        }
        xpAwardedPublisher.send(.init(habitID: habitID, amount: gained))

    }
}
private func streakMultiplier(for streak: Int) -> Double {
    // Streak = 1 ➜ 1.00×  (no bonus)
    // Streak = 2 ➜ 1.10×
    // Streak = 3 ➜ 1.20×   … capped at 2× so it doesn’t explode
    return min(1.0 + 0.10 * Double(max(streak - 1, 0)), 2.0)
}
