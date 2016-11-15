//
//  ResultsViewController.swift
//  iQuiz
//
//  Created by iGuest on 11/10/16.
//  Copyright © 2016 yulongproductions. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var numberCorrect: Int!
    var totalQuestions: Int!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        resultLabel.text = "You got \(self.numberCorrect!)/\(self.totalQuestions!) right"
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
