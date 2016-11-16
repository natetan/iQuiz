//
//  QuizTableViewController.swift
//  iQuiz
//
//  Created by Yulong Tan on 11/3/16.
//  Copyright © 2016 yulongproductions. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController {
    var passTitle: String!
    
    var model : [[String:String]] = [
        ["category": "Science!", "desc": "Science stuff"],
        ["category": "Marvel Super Heroes", "desc": "Spider-Man and his homies"],
        ["category": "Mathematics", "desc": "Math stuff",]
    ]
    
    var questions : [[String]] = [
        ["What is water"],
        ["Who is Spider-Man's crime-fighting partner and lover?"],
        ["What is the absolute value of -2?"]
    ]
    
    var answers : [[[String]]] = [
        [["H20","The thing in the ocean","You tell me","lol idk"]],
        [["Elektra Natachios", "Gwen Stacy", "Mary Jane Watson", "Felicia Hardy"]],
        [["2","-2","It's a trick question","Absolution"]]
    ]
    
    var answerIdentifier : [[String]] = [
        ["1"],
        ["4"],
        ["1"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // JSON request
        let requestURL: URL = URL(string: "http://tednewardsandbox.site44.com/questions.json")!
        let urlRequest: MutableURLRequest = MutableURLRequest(url: requestURL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("JSON request successful")
                
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [Dictionary<String,AnyObject>] {
                        print ("category count: \(json?.count)")
                        for index in 0...(json?.count)! - 1 {
                            if let subject = json?[index] {
                                //NSLog("Subject \(index): \(subject["title"] as! String), \(subject["desc"] as! String)")
                                if let title = subject["title"] as? String {
                                    self.model[index]["category"] = title
                                }
                                if let desc = subject["desc"] as? String {
                                    self.model[index]["desc"] = desc
                                }
                                if let questions = subject["questions"] as? [Dictionary<String, AnyObject>] {
                                    NSLog("Questions: \(questions)")
                                    print("Question Count for category: \(questions.count)")
                                    
                                    for i in 0...questions.count - 1 {
                                        NSLog("Question \(i): \(questions[i])")
                                        if let text = questions[i]["text"] as? String {
                                            self.questions[index].append(text)
                                        }
                                        if let answer = questions[i]["answer"] as? String {
                                            self.answerIdentifier[index].append(answer)
                                        }
                                        if let answers = questions[i]["answers"] as? [String] {
                                            self.answers[index].append(answers)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    //                    let titles = json?[0]["title"] as! String
                    //print(titles)
                } catch {
                    print("Error with json: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func settingsButton(_ sender: AnyObject) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Settings go here", message: "", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue!, sender: Any?) {
        if segue.identifier == "cellToQuestion", let questionViewController = segue.destination as? QuestionViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                passTitle = model[indexPath.row]["category"]
                questionViewController.titlePassed = self.passTitle
                questionViewController.questionPassed = self.questions[indexPath.row]
                questionViewController.answers = self.answers[indexPath.row]
                questionViewController.answerIdentifer = self.answerIdentifier[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Quiz Cell", for: indexPath) as! QuizTableViewCell
        
        // Configure the cell...
        let title = model[indexPath.row]["category"]!
        let description = model[indexPath.row]["desc"]!
        let image = model[indexPath.row]["category"]!
        cell.titleLabel.text = title
        cell.descLabel.text = description
        cell.setImage(imageName: image)
        
        return cell
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
