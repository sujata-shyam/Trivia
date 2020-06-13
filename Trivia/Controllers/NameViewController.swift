//
//  NameViewController.swift
//  Trivia
//
//  Created by Sujata on 12/06/20.
//  Copyright © 2020 Sujata. All rights reserved.
//

import UIKit

class NameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.delegate = self
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        if(tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            
            defaults.set(tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "userName")
            performSegue(withIdentifier: "segueCricketer", sender: nil)
        }
        else{
            displayAlert(vc: self, title: "", message: "Please enter your name.")
            self.tfName.becomeFirstResponder()
        }
    }
    
}
