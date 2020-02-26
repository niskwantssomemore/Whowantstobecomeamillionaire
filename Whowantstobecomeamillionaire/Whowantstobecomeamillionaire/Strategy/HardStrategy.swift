//
//  HardStrategy.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 26/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import Foundation

final class HardStrategy: CreateQuestionsOrder {
    func createOrder(questions: [Question]) -> [Int] {
        var order: [Int] = []
        var x: Int = 0
        var flag: Int = 0
        while x < questions.count {
            let number = Int.random(in: 0 ..< questions.count)
            var y: Int = 0
            while y < order.count {
                if number != order[y]
                {
                    y += 1
                }
                else
                {
                    flag = 1
                    y = order.count
                }
            }
            if (flag == 0)
            {
                order.append(number)
                x += 1
            }
            else
            {
                flag = 0
            }
        }
        return order
    }
}
