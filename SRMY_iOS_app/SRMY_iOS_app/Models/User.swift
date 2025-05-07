//
//  User.swift
//  SRMY_iOS_app
//
//  Created by user on 2025/05/04.
//

import Foundation
import SwiftUI

//can be updated later, currently only the necessity for LevelService.js

struct UserProfile: Codable {
    var name:  String        = "Player"
    var level: Int           = 1
    var xp:    Int           = 0
}
