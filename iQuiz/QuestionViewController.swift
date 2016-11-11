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
    var questionPassed: String!
    var answers: [String] = []

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("QuestionViewController didItLoad")
        // Do any additional setup after loading the view.
        titleLabel.text = titlePassed
        questionLabel.text = questionPassed
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        button4.setTitle(answers[3], for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func option1(_ sender: AnyObject) {
        select(button: button1)
        unselect(button: button2)
        unselect(button: button3)
        unselect(button: button4)
    }
    
    @IBAction func option2(_ sender: AnyObject) {
        select(button: button2)
        unselect(button: button1)
        unselect(button: button3)
        unselect(button: button4)
    }
    
    @IBAction func option3(_ sender: AnyObject) {
        select(button: button3)
        unselect(button: button1)
        unselect(button: button2)
        unselect(button: button4)
    }
    
    
    @IBAction func option4(_ sender: AnyObject) {
        select(button: button4)
        unselect(button: button1)
        unselect(button: button2)
        unselect(button: button3)
    }
    
    func select(button: UIButton) {
        button.isSelected = true
        button.backgroundColor = UIColor.gray
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
