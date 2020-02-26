//
//  MainViewController.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 17/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var lastResultLabel: UILabel!
    public var selectedDifficulty: Difficulty = .easy
    var caretaker = GameCaretaker()
    override func viewDidLoad() {
        super.viewDidLoad()
        let records = try! self.caretaker.loadGame()
        GameResults.shared.getSavedRecords(records)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
        case "startGameSegue":
            guard let destination = segue.destination as? GameCollectionViewController else { return }
            destination.selectedDifficulty = selectedDifficulty
            destination.onGameEnd = { [weak self] result in
                self?.lastResultLabel.text = "Ваш последний выигрыш: \(result)"
                try! self?.caretaker.saveGame(GameResults.shared.records)
            }
        case .none:
            break
        case .some(_):
            break
        }
    }
}
