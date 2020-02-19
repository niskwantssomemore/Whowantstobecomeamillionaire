//
//  AnswerCollectionViewCell.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 17/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class AnswerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var answerButton: UIButton!
    func configure (with answer: String) {
        answerButton.setTitle(answer, for: .normal)
    }
}
