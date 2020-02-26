//
//  PercentCollectionViewCell.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 26/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class PercentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var percentLabel: UILabel!
    func configure (with responseRate: Observable<Double>) {
        responseRate.addObserver(self, options: [.new, .initial], closure: { [weak self] (responseRate, _) in
            self?.percentLabel.text = "Доля отвеченных вопросов \(Double(round(responseRate*1000)/1000))"
        })
    }
}
