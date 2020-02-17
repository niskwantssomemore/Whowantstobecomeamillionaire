//
//  Question.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 17/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation

class Question {
    var question: String
    var rightAnswer: String
    var answer2: String
    var answer3: String
    var answer4: String
    init(question: String, rightAnswer: String, answer2: String, answer3: String, answer4: String) {
        self.question = question
        self.rightAnswer = rightAnswer
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
    }
}
