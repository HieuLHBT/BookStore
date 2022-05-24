//
//  FoodManagementDatabase.swift
//  FoodManagement2020
//
//  Created by Cuong Tieu-Kim on 1/18/21.
//

import Foundation
import UIKit
import os.log

class UserDatabase {
    //MARK: Database Properties
    let dPath: String
    let DB_NAME: String = "Books.sqlite"
    let db: FMDatabase?
    
    //MARK: Tables's properties
    let TABLE_NAME: String = "users"
    let USERNAME: String = "username"
    let PASSWORD: String = "password"
    let EMAIL: String = "email"
    let CHECK: String = "checkuser"
    
    //MARK: Database Primitives
    init() {
        let directories:[String] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        dPath = directories[0] + "/" + DB_NAME
        db = FMDatabase(path: dPath)
        if db == nil {
            os_log("Can not create the database. Please review the dPath!")
        }
        else {
            os_log("Database is created successful!")
            createTables()
        }
    }
    // Create table
    func createTables() {
        if open() {
            let sql = "CREATE TABLE " + TABLE_NAME + "( "
            + USERNAME + " TEXT PRIMARY KEY, "
            + PASSWORD + " TEXT, "
            + EMAIL + " TEXT, "
            + CHECK + " TEXT )"
            if db!.executeStatements(sql) {
                os_log("Table is created!")
            }
            else {
                os_log("Can not create the table!")
            }
        }
        else {
            os_log("Database is nil!")
        }
        close()
    }
    // Open database
    func open() -> Bool {
        var ok: Bool = false
        if db != nil {
            if db!.open() {
                ok = true
                os_log("The database is opened!")
            }
            else {
                print("Can not open the Database: \(db!.lastErrorMessage())")
            }
        }
        else {
            os_log("Database is nil!")
        }
        return ok
    }
    // Close database
    func close(){
        if db != nil {
            db!.close()
            os_log("Database is close!")
        }
    }
    
    //MARK: Database APIs
    func signUp(user: User) -> Bool {
        if open() {
            // Transform the meal image to String
            let sql = "INSERT INTO " + TABLE_NAME + "(" + USERNAME + ", " + PASSWORD + ", " + EMAIL + ", " + CHECK + ")" + " VALUES (?, ?, ? , ?)"
            if db!.executeUpdate(sql, withArgumentsIn: [user.username, user.password, user.email, user.check]) {
                os_log("The user is insert to the database!")
                close()
                return true
            }
            else {
                os_log("Fail to insert the book!")
            }
        }
        else {
            os_log("Database is nil!")
        }
        close()
        return false
    }
    
    func checkLogin(username: String, password: String) -> String {
        if open() {
            var results: FMResultSet?
            let sql = "SELECT * FROM \(TABLE_NAME) WHERE \(USERNAME) = ? and \(PASSWORD) = ?"
            // Query
            do {
                results = try db!.executeQuery(sql, values: [username, password])
            }
            catch {
                print("Fail to read data: \(error.localizedDescription)")
            }
            // Read data from the results
            if results != nil {
                while (results?.next())! {
                    let check = results!.string(forColumn: CHECK)
                    close()
                    return check ?? "2"
                }
            }
        }
        else{
            os_log("Database is nil!")
        }
        close()
        return "2"
    }
    
    func checkForgot(username: String, email: String) -> Bool {
        if open() {
            var results: FMResultSet?
            let sql = "SELECT * FROM \(TABLE_NAME) WHERE \(USERNAME) = ? and \(EMAIL) = ?"
            // Query
            do {
                results = try db!.executeQuery(sql, values: [username, email])
            }
            catch {
                print("Fail to read data: \(error.localizedDescription)")
            }
            // Read data from the results
            if results != nil {
                while (results?.next())! {
                    if results!.string(forColumn: CHECK) != nil {
                        close()
                        forgotPassword(username: username, email: email)
                        return true
                    }
                }
            }
        }
        else{
            os_log("Database is nil!")
        }
        close()
        return false
    }
    
    func forgotPassword(username: String, email: String) {
        if open() {
            let sql = "UPDATE \(TABLE_NAME) SET \(PASSWORD) = ? WHERE \(USERNAME) = ? AND \(EMAIL) = ?"
            // Try to query the database
            do{
                try db!.executeUpdate(sql, values: ["123456", username, email])
                os_log("Successful to update the book!")
            }
            catch{
                print("Fail to update the book: \(error.localizedDescription)")
            }
            
        }
        else {
            os_log("Database is nil!")
        }
        close()
    }
    
    func readUserList() -> [User] {
        var users = [User]()
        if open() {
            var results: FMResultSet?
            let sql = "SELECT * FROM \(TABLE_NAME)"
            // Query
            do {
                results = try db!.executeQuery(sql, values: nil)
            }
            catch {
                print("Fail to read data: \(error.localizedDescription)")
            }
            // Read data from the results
            if results != nil {
                while (results?.next())! {
                    let username = results!.string(forColumn: USERNAME)
                    let password = results!.string(forColumn: PASSWORD)
                    let email = results!.string(forColumn: EMAIL)
                    let checkuser = results!.string(forColumn: CHECK)
                    let user = User(username: username!, password: password!, email: email!, check: checkuser!)
                    users.append(user!)
                }
            }
        }
        else{
            os_log("Database is nil!")
        }
        close()
        return users
    }
}
