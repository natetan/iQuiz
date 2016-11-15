//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Yulong Tan on 11/8/16.
//  Copyright © 2016 yulongproductions. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var titlePassed: String!
    var questionPassed: [String]!
    var answers: [[String]]!
    var selectedAnswer: String!
    var answerIdentifer: [String]!
    var answerChosen: String = "1"
    var numberCorrect: Int!
    var questionNumber: Int!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = titlePassed
        if (questionNumber == nil) {
            questionNumber = 0
        }
        questionLabel.text = questionPassed[questionNumber]
        nextButton.isHidden = true
        button1.setTitle(answers[questionNumber][0], for: .normal)
        button2.setTitle(answers[questionNumber][1], for: .normal)
        button3.setTitle(answers[questionNumber][2], for: .normal)
        button4.setTitle(answers[questionNumber][3], for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue!, sender: Any?) {
        if segue.identifier == "questionToAnswer", let answerViewController = segue.destination as? AnswerViewController {
            answerViewController.passedAnswer = self.selectedAnswer
            answerViewController.passedQuestion = self.questionPassed
            answerViewController.answerChosen = self.answerChosen
            answerViewController.answerIdentifer = self.answerIdentifer
            answerViewController.titlePassed = self.titlePassed
            answerViewController.answers = self.answers
            answerViewController.questionNumber = self.questionNumber
            if (numberCorrect == nil) {
                numberCorrect = 0
            }
            answerViewController.numberCorrect = self.numberCorrect
        }
    }
    
    @IBAction func option1(_ sender: AnyObject) {
        select(button: button1)
        unselect(button: button2)
        unselect(button: button3)
        unselect(button: button4)
        answerChosen = "1"
    }
    
    @IBAction func option2(_ sender: AnyObject) {
        select(button: button2)
        unselect(button: button1)
        unselect(button: button3)
        unselect(button: button4)
        answerChosen = "2"
    }
    
    @IBAction func option3(_ sender: AnyObject) {
        select(button: button3)
        unselect(button: button1)
        unselect(button: button2)
        unselect(button: button4)
        answerChosen = "3"
    }
    
    
    @IBAction func option4(_ sender: AnyObject) {
        select(button: button4)
        unselect(button: button1)
        unselect(button: button2)
        unselect(button: button3)
        answerChosen = "4"
    }
    
    func select(button: UIButton) {
        button.isSelected = true
        nextButton.isHidden = false
        selectedAnswer = button.titleLabel!.text
    }
    
    func unselect(button: UIButton) {
        button.isSelected = false
        button.backgroundColor = UIColor.white
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
