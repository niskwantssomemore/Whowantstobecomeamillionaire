//
//  HintsCollectionViewCell.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 17/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class HintsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var fiftyButton: UIButton!
    @IBOutlet weak var insuranceButton: UIButton!
    func configure () {
        if (Game.shared.GameSession!.fifty == true)
        {
            fiftyButton.setTitle("50:50", for: .normal)
        }
        else
        {
            fiftyButton.setTitle("50:50", for: .normal)
            fiftyButton.backgroundColor = .black
        }
        if (Game.shared.GameSession!.insurance == true)
        {
            insuranceButton.setTitle("Право на ошибку", for: .normal)
        }
        else
        {
            insuranceButton.setTitle("Право на ошибку", for: .normal)
            insuranceButton.backgroundColor = .black
        }
    }
}
