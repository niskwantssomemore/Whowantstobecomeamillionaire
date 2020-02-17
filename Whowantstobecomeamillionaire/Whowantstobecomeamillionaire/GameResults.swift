//
//  GameResults.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 17/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation

class GameResults {
    var records: [Record] = []
    static var shared = GameResults()
    private init() { }
    func addRecord(_ result: Int) {
        let record = Record(date: Date(), score: result)
        self.records.append(record)
    }
    func getSavedRecords(_ savedRecords: [Record]) {
        records.removeAll()
        records.append(contentsOf: savedRecords)
    }
}

struct Record: Codable {
    let date: Date
    let score: Int
}
