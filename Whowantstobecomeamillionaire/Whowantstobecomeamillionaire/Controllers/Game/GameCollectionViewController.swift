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
    var isFiftyTapped: Bool = false
    var isInsuranceTapped: Bool = false
    var caretaker = GameCaretaker()
    var responseRate = Observable<Double>(0.0)
    public var questions: [Question] = []
    public var selectedDifficulty: Difficulty?
    private let createOrder: CreateQuestionsOrder = EasyStrategy()
    var questionOrder: [Int] = []
    var answerOrder: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        questions = try! self.caretaker.loadQuestion()
        questions.append(Question(question: "Кто 1-м получил Нобелевскую премию по литературе?", rightAnswer: "Поэт", answer2: "Романист", answer3: "Драматург", answer4: "Эссеист"))
        questions.append(Question(question: "С какой буквы начинаются слова, опубликованные в 16-м томе последнего издания Большой советской энциклопедии?", rightAnswer: "М", answer2: "Н", answer3: "О", answer4: "П"))
        questions.append(Question(question: "Сколько раз в сутки подзаводят куранты Спасской башни Кремля?", rightAnswer: "Два", answer2: "Один", answer3: "Четыре", answer4: "Три"))
        questions.append(Question(question: "Какой химический элемент назван в честь злого подземного гнома?", rightAnswer: "Кобальт", answer2: "Гафний", answer3: "Бериллий", answer4: "Теллур"))
        questions.append(Question(question: "В какой из этих столиц бывших союзных республик раньше появилось метро?", rightAnswer: "Тбилиси", answer2: "Ереван", answer3: "Баку", answer4: "Минск"))
        let session = GameSession(questionNumber: 0, win: 0, difficulty: selectedDifficulty!)
        Game.shared.GameSession = session
        var createStrategy: CreateQuestionsOrder {
            switch Game.shared.GameSession!.difficulty {
            case .easy:
                return EasyStrategy()
            case .hard:
                return HardStrategy()
            }
        }
        answerOrder = randomAnswerOrder(answerOrder: answerOrder)
        questionOrder = createStrategy.createOrder(questions: questions)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCollectionViewCell", for: indexPath) as! QuestionCollectionViewCell
            cell.configure(with: questions[questionOrder[Game.shared.GameSession!.questionNumber]].question)
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HintsCollectionViewCell", for: indexPath) as! HintsCollectionViewCell
            cell.configure()
            return cell
        }
        else if indexPath.row == answerOrder[0]
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[questionOrder[Game.shared.GameSession!.questionNumber]].rightAnswer)
            return cell
        }
        else if indexPath.row == answerOrder[1]
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            cell.configure(with: questions[questionOrder[Game.shared.GameSession!.questionNumber]].answer2)
            return cell
        }
        else if indexPath.row == answerOrder[2]
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            if (isFiftyTapped == false)
            {
                cell.configure(with: questions[questionOrder[Game.shared.GameSession!.questionNumber]].answer3)
            }
            else
            {
                cell.configure(with: "")
            }
            return cell
        }
        else if indexPath.row == answerOrder[3]
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnswerCollectionViewCell", for: indexPath) as! AnswerCollectionViewCell
            if (isFiftyTapped == false)
            {
                cell.configure(with: questions[questionOrder[Game.shared.GameSession!.questionNumber]].answer4)
            }
            else
            {
                cell.configure(with: "")
            }
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PercentCollectionViewCell", for: indexPath) as! PercentCollectionViewCell
            responseRate.value = Double(Game.shared.GameSession!.questionNumber) / Double(questions.count)
            cell.configure(with: responseRate)
            return cell
        }
    }
    @IBAction func answerTapped(_ sender: UIButton) {
        if (sender.titleLabel?.text == questions[questionOrder[Game.shared.GameSession!.questionNumber]].rightAnswer && Game.shared.GameSession!.questionNumber < questions.count - 1)
        {
            if (Game.shared.GameSession!.questionNumber == 0)
            {
                Game.shared.GameSession!.win = 10
            }
            else
            {
                Game.shared.GameSession!.win *= 10
            }
            if (isFiftyTapped == true)
            {
                isFiftyTapped = false
            }
            if (isInsuranceTapped == true)
            {
                isInsuranceTapped = false
            }
            answerOrder = randomAnswerOrder(answerOrder: answerOrder)
            Game.shared.GameSession!.questionNumber += 1
            collectionView.reloadData()
        }
        else if (sender.titleLabel?.text != questions[questionOrder[Game.shared.GameSession!.questionNumber]].rightAnswer)
        {
            if (isInsuranceTapped == false)
            {
                if (isFiftyTapped == true)
                {
                    isFiftyTapped = false
                }
                GameResults.shared.addRecord(Game.shared.GameSession!.win)
                self.onGameEnd?(Game.shared.GameSession!.win)
                self.dismiss(animated: true, completion: nil)
            }
            else
            {
                if (isFiftyTapped == true)
                {
                    isFiftyTapped = false
                }
                if (Game.shared.GameSession!.questionNumber < questions.count - 1)
                {
                    answerOrder = randomAnswerOrder(answerOrder: answerOrder)
                    Game.shared.GameSession!.questionNumber += 1
                    isInsuranceTapped = false
                    collectionView.reloadData()
                }
                else
                {
                    GameResults.shared.addRecord(Game.shared.GameSession!.win)
                    self.onGameEnd?(Game.shared.GameSession!.win)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        else
        {
            if (isFiftyTapped == true)
            {
                isFiftyTapped = false
            }
            if (isInsuranceTapped == true)
            {
                isInsuranceTapped = false
            }
            Game.shared.GameSession!.win *= 10
            GameResults.shared.addRecord(Game.shared.GameSession!.win)
            self.onGameEnd?(Game.shared.GameSession!.win)
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func fiftyTapped(_ sender: UIButton) {
        if (Game.shared.GameSession!.fifty == true)
        {
            Game.shared.GameSession!.fifty = false
            isFiftyTapped = true
            collectionView.reloadData()
        }
    }
    @IBAction func insuranceTapped(_ sender: UIButton) {
        if (Game.shared.GameSession!.insurance == true)
        {
            Game.shared.GameSession!.insurance = false
            isInsuranceTapped = true
            collectionView.reloadData()
        }
    }
    func randomAnswerOrder(answerOrder: [Int]) -> [Int] {
        var order: [Int] = []
        var x: Int = 0
        var flag: Int = 0
        while x < 4 {
            let number = Int.random(in: 2 ..< 6)
            var y: Int = 0
            while y < order.count {
                if number != order[y]
                {
                    y += 1
                }
                else
                {
                    flag = 1
                    y = order.count
                }
            }
            if (flag == 0)
            {
                order.append(number)
                x += 1
            }
            else
            {
                flag = 0
            }
        }
        return order
    }
}
extension GameCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.width
    }
}
