//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Yulong Tan on 11/8/16.
//  Copyright © 2016 yulongproductions. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var passedAnswer: String!
    var passedQuestion: String!
    var answerChosen: String!
    var answerIdentifer: String!
    var numberCorrect: Int!
    var questionNumber: Int!

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        answerLabel.text = "You chose: \(passedAnswer!)"
        questionLabel.text = passedQuestion
        resultLabel.textColor = UIColor.red
        if (answerIdentifer == answerChosen) {
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
        if segue.identifier == "answerToResults", let resultsViewController = segue.destination as? ResultsViewController {
            resultsViewController.numberCorrect = self.numberCorrect
        }
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
