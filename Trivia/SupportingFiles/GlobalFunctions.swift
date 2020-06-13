//
//  GlobalFunctions.swift
//  Trivia
//
//  Created by Sujata on 12/06/20.
//  Copyright © 2020 Sujata. All rights reserved.
//

import UIKit

struct  UserDetails {
    let id:Int?
    let eventDate:String?
    let name:String?
    let questionOne:String?
    let answerOne:String?
    let questionTwo:String?
    let answerTwo:String?
}

let defaults = UserDefaults.standard

func displayAlert(vc: UIViewController, title: String, message: String) {
    let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler:nil ))
    vc.present(alert, animated: true)
}


