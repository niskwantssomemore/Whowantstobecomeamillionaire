//
//  QuestionCollectionViewCell.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 17/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    func configure (with question: String) {
        questionLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width
        questionLabel.text = "\(Game.shared.questionNumber + 1). \(question)"
    }
    
}
