//
//  ResultsTableViewCell.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 17/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var dateResultLabel: UILabel!
    @IBOutlet weak var scoreResultLabel: UILabel!
    public func configure(with record: Record) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let localDate = dateFormatter.string(from: record.date)
        dateResultLabel.text = "\(localDate)"
        scoreResultLabel.text = "\(record.score)"
    }
}
