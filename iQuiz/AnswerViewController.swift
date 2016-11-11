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

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        answerLabel.text = "You selected \(passedAnswer)"
        questionLabel.text = passedQuestion
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
