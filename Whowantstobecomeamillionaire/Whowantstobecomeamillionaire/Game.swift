//
//  Game.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 19/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation

class Game {
    private init() {}
    public static let shared = Game()
    var GameSession: GameSession?
}
class GameSession {
    var questionNumber: Int
    var win: Int
    var difficulty: Difficulty = .easy
    init(questionNumber: Int, win: Int) {
        self.questionNumber = questionNumber
        self.win = win
    }
}
