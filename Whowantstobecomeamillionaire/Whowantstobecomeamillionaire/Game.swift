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
    var questionNumber: Int = 0
    var win: Int = 0
}
