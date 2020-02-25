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
    var caretaker = GameCaretaker()
    public var questions: [Question] = []
    public var selectedDifficulty: Difficulty?
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = try! self.caretaker.loadQuestion()
        questions.append(Question(question: "Кто 1-м получил Нобелевскую премию по литературе?", rightAnswer: "Поэт", answer2: "Романист", answer3: "Драматург", answer4: "Эссеист"))
        questions.append(Question(question: "С какой буквы начинаются слова, опубликованные в 16-м томе последнего издания Большой советской энциклопедии?", rightAnswer: "М", answer2: "Н", answer3: "О", answer4: "П"))
        questions.append(Question(question: "Сколько раз в сутки подзаводят куранты Спасской башни Кремля?", rightAnswer: "Два", answer2: "Один", answer3: "Четыре", answer4: "Три"))
        questions.append(Question(question: "Какой химический элемент назван в честь злого подземного гнома?", rightAnswer: "Кобальт", answer2: "Гафний", answer3: "Бериллий", answer4: "Теллур"))
        questions.append(Question(question: "В какой из этих столиц бывших союзных республик раньше появилось метро?", rightAnswer: "Тбилиси", answer2: "Ереван", answer3: "Баку", answer4: "Минск"))
        let session = GameSession(questionNumber: 0, win: 0)
        Game.shared.GameSession = session
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
            cell.configure(with: questions[Game.shared.GameSession!.questionNumber].question)
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[Game.shared.GameSession!.questionNumber].rightAnswer)
            return cell
        }
        else if indexPath.row == 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[Game.shared.GameSession!.questionNumber].answer2)
            return cell
        }
        else if indexPath.row == 3
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[Game.shared.GameSession!.questionNumber].answer3)
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[Game.shared.GameSession!.questionNumber].answer4)
            return cell
        }
    }
    @IBAction func answerTapped(_ sender: UIButton) {
        if (sender.titleLabel?.text == questions[Game.shared.GameSession!.questionNumber].rightAnswer && Game.shared.GameSession!.questionNumber < questions.count - 1)
        {
            if (Game.shared.GameSession!.questionNumber == 0)
            {
                Game.shared.GameSession!.win = 1000
            }
            else
            {
                Game.shared.GameSession!.win *= 10
            }
            Game.shared.GameSession!.questionNumber += 1
            collectionView.reloadData()
        }
        else if (sender.titleLabel?.text != questions[Game.shared.GameSession!.questionNumber].rightAnswer)
        {
            GameResults.shared.addRecord(Game.shared.GameSession!.win)
            Game.shared.GameSession!.win = 0
            Game.shared.GameSession!.questionNumber = 0
            self.onGameEnd?(Game.shared.GameSession!.win)
            self.dismiss(animated: true, completion: nil)
        }
        else
        {
            Game.shared.GameSession!.win = 1000000
            GameResults.shared.addRecord(Game.shared.GameSession!.win)
            Game.shared.GameSession!.win = 0
            Game.shared.GameSession!.questionNumber = 0
            self.onGameEnd?(Game.shared.GameSession!.win)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
extension GameCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.width
    }
}
