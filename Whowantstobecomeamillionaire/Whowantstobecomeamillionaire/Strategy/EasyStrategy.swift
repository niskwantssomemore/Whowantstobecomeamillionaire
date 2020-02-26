//
//  EasyStrategy.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 26/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation

final class EasyStrategy: CreateQuestionsOrder {
    func createOrder(questions: [Question]) -> [Int] {
        var order: [Int] = []
        var i: Int = 0
        while i < questions.count {
            order.append(i)
            i += 1
        }
        return order
    }
}
