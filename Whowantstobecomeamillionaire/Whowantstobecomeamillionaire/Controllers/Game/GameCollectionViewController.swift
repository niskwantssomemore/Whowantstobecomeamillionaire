//
//  GameCollectionViewController.swift
//  Whowantstobecomeamillionaire
//
//  Created by Aleksei Niskarav on 17/02/2020.
//  Copyright © 2020 Aleksei Niskarav. All rights reserved.
//

import UIKit

class GameCollectionViewController: UICollectionViewController {
    var onGameEnd: ((Int) -> Void)?
    public var questions = [
        Question(question: "Кто 1-м получил Нобелевскую премию по литературе?", rightAnswer: "Поэт", answer2: "Романист", answer3: "Драматург", answer4: "Эссеист"),
        Question(question: "С какой буквы начинаются слова, опубликованные в 16-м томе последнего издания Большой советской энциклопедии?", rightAnswer: "М", answer2: "Н", answer3: "О", answer4: "П"),
        Question(question: "Сколько раз в сутки подзаводят куранты Спасской башни Кремля?", rightAnswer: "Два", answer2: "Один", answer3: "Четыре", answer4: "Три"),
        Question(question: "Какой химический элемент назван в честь злого подземного гнома?", rightAnswer: "Кобальт", answer2: "Гафний", answer3: "Бериллий", answer4: "Теллур"),
        Question(question: "В какой из этих столиц бывших союзных республик раньше появилось метро?", rightAnswer: "Тбилиси", answer2: "Ереван", answer3: "Баку", answer4: "Минск")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCollectionViewCell", for: indexPath) as! QuestionCollectionViewCell
            cell.configure(with: questions[Game.shared.questionNumber].question)
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[Game.shared.questionNumber].rightAnswer)
            return cell
        }
        else if indexPath.row == 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[Game.shared.questionNumber].answer2)
            return cell
        }
        else if indexPath.row == 3
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[Game.shared.questionNumber].answer3)
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[Game.shared.questionNumber].answer4)
            return cell
        }
    }
    @IBAction func answerTapped(_ sender: UIButton) {
        if (sender.titleLabel?.text == questions[Game.shared.questionNumber].rightAnswer && Game.shared.questionNumber < questions.count - 1)
        {
            if (Game.shared.questionNumber == 0)
            {
                Game.shared.win = 1000
            }
            else if (Game.shared.questionNumber == 3)
            {
                Game.shared.win = 500000
            }
            else
            {
                Game.shared.win *= 10
            }
            Game.shared.questionNumber += 1
            collectionView.reloadData()
        }
        else if (sender.titleLabel?.text != questions[Game.shared.questionNumber].rightAnswer)
        {
            GameResults.shared.addRecord(Game.shared.win)
            Game.shared.win = 0
            Game.shared.questionNumber = 0
            self.onGameEnd?(Game.shared.win)
            self.dismiss(animated: true, completion: nil)
        }
        else
        {
            Game.shared.win = 1000000
            GameResults.shared.addRecord(Game.shared.win)
            Game.shared.win = 0
            Game.shared.questionNumber = 0
            self.onGameEnd?(Game.shared.win)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
extension GameCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.width
    }
}
