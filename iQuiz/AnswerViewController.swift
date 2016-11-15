//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Yulong Tan on 11/8/16.
//  Copyright © 2016 yulongproductions. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var titlePassed: String!
    var passedAnswer: String!
    var passedQuestion: [String]!
    var answerChosen: String!
    var answerIdentifer: [String]!
    var numberCorrect: Int!
    var questionNumber: Int!
    var totalQuestions: Int!
    var answers: [[String]]!
    
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        answerLabel.text = "You chose: \(passedAnswer!)"
        if (questionNumber == nil) {
            questionNumber = 0
        }
        questionLabel.text = passedQuestion[questionNumber]
        resultLabel.textColor = UIColor.red
        if (answerIdentifer[questionNumber] == answerChosen) {
            resultLabel.text = "Correct!"
            resultLabel.textColor = UIColor.green
            numberCorrect = numberCorrect + 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue!, sender: Any?) {
        if (totalQuestions - 1 > questionNumber) {
            
            print (totalQuestions)
            print (questionNumber)
            let nextQuestion = segue.destination as! QuestionViewController
            nextQuestion.questionNumber = self.questionNumber + 1
            nextQuestion.numberCorrect = self.numberCorrect
            nextQuestion.titlePassed = self.titlePassed
            nextQuestion.answerIdentifer = self.answerIdentifer
            nextQuestion.questionPassed = self.passedQuestion
            nextQuestion.answers = self.answers
            
        } else {
            let results = segue.destination as! ResultsViewController
            results.numberCorrect = self.numberCorrect
            
        }
    }
    
    @IBAction func nextButton(_ sender: AnyObject) {
        print (totalQuestions)
        print (questionNumber)
        var destination = "answerToResults"
        if (totalQuestions - 1 > questionNumber) {
            destination = "answerToQuestion"
        }
        self.performSegue(withIdentifier: destination, sender: self)
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
