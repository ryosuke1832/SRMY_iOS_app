//
//  LevelServiceTests.swift
//  SRMY_iOS_app
//
//  Created by Lora on 2025/5/6.
//



import XCTest
import ViewInspector
@testable import SRMY_iOS_app


final class Smoke: XCTestCase {
    func testLinker() {
        XCTAssertTrue(true)     // if this runs, linking is fixed
    }
}

final class LevelServiceTests: XCTestCase {

    func testAwardXP_noCombo_noStreak() {
        let ls = LevelService()
        ls.awardXP(base: 10, comboIndex: 0, streak: 1)   // 10 × 1 × 1
        XCTAssertEqual(ls.profile.xp, 10)
        XCTAssertEqual(ls.profile.level, 1)
    }

    func testAwardXP_combo1_streak3() {
        let ls = LevelService()
        ls.awardXP(base: 10, comboIndex: 1, streak: 3)   // 10 × 1.25 × 1.2 = 15
        XCTAssertEqual(ls.profile.xp, 15)
    }

    func testLevelUp() {
        let ls = LevelService()
        ls.awardXP(base: 50, comboIndex: 0, streak: 1)   // exactly level‑up threshold
        XCTAssertEqual(ls.profile.level, 2)
        XCTAssertEqual(ls.profile.xp, 0)
    }
}

final class HabitServiceTests: XCTestCase {
    func testCompletionAwardsXP() {
        let level = LevelService()
        let habits = HabitService(levelService: level)

        habits.addHabit(name: "Drink water", goalDays: 1)
        let h = habits.habits[0]
        habits.markHabitAsCompleted(h)

        XCTAssertEqual(level.profile.xp, 25)
    }
}


final class LevelViewTests: XCTestCase {

    func testConfettiFiresWhenProgressResets() throws {

        // a service whose XP is 10 short of levelling‑up
        let svc = LevelService()
        let needed = svc.xpNeeded(for: svc.profile.level) // 50
        svc.awardXP(base: needed - 10, comboIndex: 0, streak: 1) // now at 40 XP

        // SwiftUI view under test
        let view = LevelView().environmentObject(svc)


        _ = try view.inspect().view(LevelView.self)

        // WHEN we add enough XP to cross the threshold
        svc.awardXP(base: 15, comboIndex: 0, streak: 1) // total 55 → level up

        // THEN confettiCounter should tick from 0 → 1
        let counter = try view.inspect()
                              .view(LevelView.self)
                              .actualView()._test_confettiCounter
        XCTAssertEqual(counter, 1)

    }
}
