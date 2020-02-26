//
//  Strategy.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 26/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation

protocol CreateQuestionsOrder {
    func createOrder(questions: [Question]) -> [Int]
}
