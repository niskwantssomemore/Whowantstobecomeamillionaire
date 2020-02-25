//
//  QuestionViewController.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 25/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class CreateQuestionViewController: UIViewController {
    @IBOutlet var questionTextfield: UITextField!
    @IBOutlet var rightanswerTextfield: UITextField!
    @IBOutlet var answer1Textfield: UITextField!
    @IBOutlet var answer2Textfield: UITextField!
    @IBOutlet var answer3Textfield: UITextField!
    var caretaker = GameCaretaker()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func questionCreated(_ sender: UIButton) {
        if (questionTextfield.text != "" && rightanswerTextfield.text != "" && answer1Textfield.text != "" && answer2Textfield.text != "" && answer3Textfield.text != "")
        {
            var newquestion: [Question] = try! self.caretaker.loadQuestion()
            newquestion.append(Question(question: questionTextfield.text!, rightAnswer: rightanswerTextfield.text!, answer2: answer1Textfield.text!, answer3: answer2Textfield.text!, answer4: answer3Textfield.text!))
            try! self.caretaker.saveQuestion(newquestion)
            performSegue(withIdentifier: "Add Question", sender: nil)
        }
        else
        {
            show(message: "Заполните все поля!")
        }
    }
}
extension UIViewController {
    func show(message: String) {
        let alertVC = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
}
