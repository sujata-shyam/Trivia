//
//  SQLiteOperations.swift
//  Trivia
//
//  Created by Sujata on 13/06/20.
//  Copyright © 2020 Sujata. All rights reserved.
//

import Foundation
import SQLite3

var db: OpaquePointer? //For SQLite

//Create Database
func openDatabase(){
    do {
        //the database file
        let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("TriviaDatabase.sqlite")
        
        //opening the database
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            print("Successfully opened connection to database")
            createTable()
        }
        else {
            print("Unable to open database.")
        }
    }
    catch {
        print(error)
    }
}

//Create Table
func createTable() {
    let createTableString = """
                CREATE TABLE IF NOT EXISTS Trivia(
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                EventDate TEXT,
                Name TEXT,
                QuestionOne TEXT,
                AnswerOne TEXT,
                QuestionTwo TEXT,
                AnswerTwo TEXT);
                """
    
    if sqlite3_exec(db, createTableString, nil, nil, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error creating table: \(errmsg)")
    }
}

//Insert Data
func insertData(eventDate:String, name:String, questionOne:String, answerOne:String, questionTwo:String, answerTwo:String) {
    
    //deleteData()
    var insertStatement: OpaquePointer?
    
    //the insert query
    let queryString = "INSERT INTO Trivia(EventDate, Name, QuestionOne, AnswerOne, QuestionTwo, AnswerTwo) VALUES (?,?,?,?,?,?);"
    
    //preparing the query
    if sqlite3_prepare_v2(db, queryString, -1, &insertStatement, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: \(errmsg)")
        return
    }
    
    //binding the parameters
    if sqlite3_bind_text(insertStatement, 1, (eventDate as NSString).utf8String, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure binding eventDate: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure binding name: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(insertStatement, 3, (questionOne as NSString).utf8String, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure binding questionOne: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(insertStatement, 4, (answerOne as NSString).utf8String, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure binding answerOne: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(insertStatement, 5, (questionTwo as NSString).utf8String, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure binding questionTwo: \(errmsg)")
        return
    }
    
    if sqlite3_bind_text(insertStatement, 6, (answerTwo as NSString).utf8String, -1, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure binding answerTwo: \(errmsg)")
        return
    }
    
    //executing the query to insert values
    if sqlite3_step(insertStatement) != SQLITE_DONE {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure saving data: \(errmsg)")
        return
    }
    
    print("Details saved successfully")
    sqlite3_finalize(insertStatement)
}

func readValues()->[UserDetails]? {

    //Empty array to hold User Details
    var arrUserDetails = [UserDetails]()
    
    //this is our select query
    let queryString = "SELECT * FROM Trivia;"

    //statement pointer
    var stmt:OpaquePointer?

    //preparing the query
    if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing SELECT: \(errmsg)")
        return nil
    }

    //traversing through all the records
    while(sqlite3_step(stmt) == SQLITE_ROW){
        let id = sqlite3_column_int(stmt, 0)
        let eventDate = String(cString: sqlite3_column_text(stmt, 1))
        let userName = String(cString: sqlite3_column_text(stmt, 2))
        let questionOne = String(cString: sqlite3_column_text(stmt, 3))
        let answerOne = String(cString: sqlite3_column_text(stmt, 4))
        let questionTwo = String(cString: sqlite3_column_text(stmt, 5))
        let answerTwo = String(cString: sqlite3_column_text(stmt, 6))
        
        //adding values to the array
        arrUserDetails.append(UserDetails(id: Int(id), eventDate: eventDate, name: userName, questionOne: questionOne, answerOne: answerOne, questionTwo: questionTwo, answerTwo: answerTwo))
    }
    sqlite3_finalize(stmt)
    
    return arrUserDetails
}

//func deleteData() {
//    let deleteStatementString = "DELETE FROM Trivia;"
//    var deleteStatement: OpaquePointer?
//    if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
//        SQLITE_OK {
//        if sqlite3_step(deleteStatement) == SQLITE_DONE {
//            print("\nSuccessfully deleted row.")
//        } else {
//            print("\nCould not delete row.")
//        }
//    } else {
//        print("\nDELETE statement could not be prepared")
//    }
//    
//    sqlite3_finalize(deleteStatement)
//    
//    
//    //displaying a success message
//    print("Details deleted successfully")
//}
