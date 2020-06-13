//
//  FavCricketerViewController.swift
//  Trivia
//
//  Created by Sujata on 12/06/20.
//  Copyright © 2020 Sujata. All rights reserved.
//

import UIKit

class FavCricketerViewController: UIViewController {
    
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let arrayCricketers = ["Sachin Tendulkar", "Virat Kohli", "Adam Gilchrist", "Jacques Kallis"]

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        if(lblAnswer.text != ""){
            
            defaults.set(lblAnswer.text, forKey:"cricketerName")
            performSegue(withIdentifier: "segueFlagColors", sender: nil)
        }
        else{
            displayAlert(vc: self, title: "", message: "Please select a cricketer.")
        }
    }
}

extension FavCricketerViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayCricketers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblAnswer.text = arrayCricketers[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayCricketers[row]
    }
}
