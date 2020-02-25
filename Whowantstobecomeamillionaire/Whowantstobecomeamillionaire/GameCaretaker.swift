//
//  GameCaretaker.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 17/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation

class GameCaretaker {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "results"
    private let key1 = "questions"
    
    func saveGame(_ results: [Record]) throws {
        let data: Data = try encoder.encode(results)
        UserDefaults.standard.set(data, forKey: key)
    }
    func saveQuestion(_ questions: [Question]) throws {
        let data: Data = try encoder.encode(questions)
        UserDefaults.standard.set(data, forKey: key1)
    }
    func loadQuestion() throws -> [Question] {
        guard let data = UserDefaults.standard.value(forKey: key1) as? Data
            , let question = try? decoder.decode([Question].self, from: data) else {
                return []
        }
        return question
    }
    func loadGame() throws -> [Record] {
        guard let data = UserDefaults.standard.value(forKey: key) as? Data
            , let game = try? decoder.decode([Record].self, from: data) else {
                return []
        }
        return game
    }
    public enum Error: Swift.Error {
        case gameNotFound
    }
}
