//
//  SettingsViewController.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 25/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var difficultyControl: UISegmentedControl!
    @IBOutlet weak var confirmSettingsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private var selectedDifficulty: Difficulty {
        switch self.difficultyControl.selectedSegmentIndex {
        case 0:
            return .easy
        case 1:
            return .hard
        default:
            return .easy
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
        case "Confirm Settings":
            guard let destination = segue.destination as? MainViewController else { return }
            destination.selectedDifficulty = selectedDifficulty
        case .none:
            break
        case .some(_):
            break
        }
    }
}
