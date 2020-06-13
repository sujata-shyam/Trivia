//
//  SummaryViewController.swift
//  Trivia
//
//  Created by Sujata on 12/06/20.
//  Copyright © 2020 Sujata. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAnswerOne: UILabel!
    @IBOutlet weak var lblAnswerTwo: UILabel!
    
    lazy var listColors = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let userName = defaults.string(forKey: "userName"){
            lblName.text = "Hello \(userName)"
        }
        if let cricketerName = defaults.string(forKey: "cricketerName"){
            lblAnswerOne.text = "\(cricketerName)"
        }
        if let selectedColors = defaults.array(forKey: "selectedColors") as! [String]?{
            listColors = "\(selectedColors.joined(separator: ", "))"
            lblAnswerTwo.text = listColors
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        openDatabase()
    }
    
    @IBAction func btnFinishTapped(_ sender: UIButton) {
        //openDatabase()
        
        let currentDate = getDate()
        let userName = defaults.string(forKey: "userName")
        let firstQuestion = "Who is the best cricketer in the world?"
        let firstAnswer = defaults.string(forKey: "cricketerName")
        
        let secondQuestion = "What are the colors in the national flag?"
        let secondAnswer = listColors
        
        insertData(eventDate: currentDate, name:userName ?? "", questionOne:firstQuestion, answerOne:firstAnswer ?? "", questionTwo:secondQuestion, answerTwo:secondAnswer)
        
        clearUserDefaults()
        
        self.navigationController?.viewControllers.removeAll()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NameViewController") as! NameViewController
        
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    func getDate()->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: Date())
    }
    
    func clearUserDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
