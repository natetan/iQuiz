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
    var urlLink = "http://tednewardsandbox.site44.com/questions.json"
    
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
        makeJSONRequest(url: self.urlLink)
        
        // Setting up files for the JSON objects
        let modelFile = FileSaveHelper(fileName: "modelFile", fileExtension: .JSON, subDirectory: "SavingFiles", directory: .documentDirectory)
        let questionsFile = FileSaveHelper(fileName: "questionsFile", fileExtension: .JSON, subDirectory: "SavingFiles", directory: .documentDirectory)
        let answersFile = FileSaveHelper(fileName: "answersFile", fileExtension: .JSON, subDirectory: "SavingFiles", directory: .documentDirectory)
        let answerIdentifierFile = FileSaveHelper(fileName: "answerIdentifierFile", fileExtension: .JSON, subDirectory: "SavingFiles", directory: .documentDirectory)
        
        // Save files to local storage
        do {
            
            try modelFile.saveFile(dataForJson: self.model as AnyObject)
            try questionsFile.saveFile(dataForJson: self.questions as AnyObject)
            try answersFile.saveFile(dataForJson: self.answers as AnyObject)
            try answerIdentifierFile.saveFile(dataForJson: self.answerIdentifier as AnyObject)
        }
        catch {
            print(error)
        }
        
        // Test if files are there
        print("Model file exists: \(modelFile.fileExists)")
        print("Questions file exists: \(questionsFile.fileExists)")
        print("Answers file exists: \(answersFile.fileExists)")
        print("Answer Identifier file exists: \(answerIdentifierFile.fileExists)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeJSONRequest(url: String) {
        if (URL(string: url) == nil) {
            let alertController = UIAlertController(title: "Link is invalid. Please try again", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let requestURL: URL = URL(string: url)!
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
                                    if let title = subject["title"] as? String {
                                        self.model[index]["category"] = title
                                    }
                                    if let desc = subject["desc"] as? String {
                                        self.model[index]["desc"] = desc
                                    }
                                    if let questions = subject["questions"] as? [Dictionary<String, AnyObject>] {
                                        print("Question Count for category: \(questions.count)")
                                        
                                        for i in 0...questions.count - 1 {
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
                    } catch {
                        print("Error with json: \(error)")
                    }
                } else {
                    let modelFile = FileSaveHelper(fileName: "modelFile", fileExtension: .JSON, subDirectory: "SavingFiles", directory: .documentDirectory)
                    let questionsFile = FileSaveHelper(fileName: "questionsFile", fileExtension: .JSON, subDirectory: "SavingFiles", directory: .documentDirectory)
                    let answersFile = FileSaveHelper(fileName: "answersFile", fileExtension: .JSON, subDirectory: "SavingFiles", directory: .documentDirectory)
                    let answerIdentifierFile = FileSaveHelper(fileName: "answerIdentifierFile", fileExtension: .JSON, subDirectory: "SavingFiles", directory: .documentDirectory)
                    
                    do {
                        // This was an attempt to use the saved data in the storage, which was successfully stored in viewDidLoad
                        
//                        try self.model = modelFile.getJSONData()
//                        try self.questions = questionsFile.getJSONData()
//                        try self.answers = answersFile.getJSONData()
//                        try self.answerIdentifier = answerIdentifierFile.getJSONData()
                    }
                    catch {
                        print(error)
                    }
                    
                }
            }
            
            task.resume()
        }
        
    }
    
    @IBAction func settingsButton(_ sender: AnyObject) {
        // Create the alert controller
        let alertController = UIAlertController(title: "Settings", message: "Use custom URL", preferredStyle: .alert)
        
        // Add text field
        alertController.addTextField { (textField) in
            textField.attributedPlaceholder = NSAttributedString(string:"Type here", attributes:[NSForegroundColorAttributeName: UIColor.gray])
        }
        
        alertController.addAction(UIAlertAction(title: "Check Now", style: .default, handler: { (_) in
            self.urlLink = alertController.textFields![0].text! // Force unwrapping because we know it exists.
            self.makeJSONRequest(url: self.urlLink)
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
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
