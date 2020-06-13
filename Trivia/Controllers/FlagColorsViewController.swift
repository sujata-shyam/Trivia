//
//  FlagColorsViewController.swift
//  Trivia
//
//  Created by Sujata on 12/06/20.
//  Copyright © 2020 Sujata. All rights reserved.
//

import UIKit

class FlagColorsViewController: UIViewController {
    
    @IBOutlet var cbWhite: CheckBox!
    @IBOutlet var cbOrange: CheckBox!
    @IBOutlet var cbYellow: CheckBox!
    @IBOutlet var cbGreen: CheckBox!
    
    let colorCode = [1:"White", 2:"Orange", 3:"Yellow", 4:"Green"]
    var selectedColors = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cbWhite.style = .tick
        cbOrange.style = .tick
        cbYellow.style = .tick
        cbGreen.style = .tick

        cbWhite.borderStyle = .square
        cbOrange.borderStyle = .square
        cbYellow.borderStyle = .square
        cbGreen.borderStyle = .square
    }
    
    @IBAction func checkBoxValueChanged(_ sender: CheckBox) {
        if(sender.isChecked){
            selectedColors.append(colorCode[sender.tag]!)
        }
        else {
            selectedColors.removeAll{$0 == colorCode[sender.tag] }
        }
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        if selectedColors.count < 2 {
            displayAlert(vc: self, title: "", message: "Please select atleast two colours.")
        }
        else{
            defaults.set(selectedColors, forKey:"selectedColors")
            performSegue(withIdentifier: "segueSummary", sender: nil)
        }
    }
    
}
