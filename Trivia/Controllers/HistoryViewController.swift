//
//  HistoryViewController.swift
//  Trivia
//
//  Created by Sujata on 13/06/20.
//  Copyright © 2020 Sujata. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableViewHistory: UITableView!
    
    var userDetailsHistory = [UserDetails]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHistory.delegate = self
        tableViewHistory.dataSource = self
        
        if let userDetails = readValues()
        {
            userDetailsHistory = userDetails
            tableViewHistory.reloadData()
        }
        
    }
    
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(userDetailsHistory.count > 0 ){
            return userDetailsHistory.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellHistory", for: indexPath) as! TableViewCellForHistory

        cell.lblDate.text = "Game:\(indexPath.row) \(userDetailsHistory[indexPath.row].eventDate ?? "")"
        cell.lblName.text = userDetailsHistory[indexPath.row].name
        cell.lblAnsOne.text = userDetailsHistory[indexPath.row].answerOne
        cell.lblAnsTwo.text = userDetailsHistory[indexPath.row].answerTwo
        
        
        return cell
    }
    
    
}
