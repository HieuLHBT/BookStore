//
//  FoodManagementDatabase.swift
//  FoodManagement2020
//
//  Created by Cuong Tieu-Kim on 1/18/21.
//

import Foundation
import UIKit
import os.log

class PaymentDatabase {
    //MARK: Database Properties
    let dPath: String
    let DB_NAME: String = "Books.sqlite"
    let db: FMDatabase?
    
    //MARK: Tables's properties
    let TABLE_NAME: String = "payments"
    let PAYMENT_ID: String = "_id"
    let USERNAME: String = "username"
    
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
            + PAYMENT_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, "
            + USERNAME + " TEXT) "
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
        }
    }
    
    //MARK: Database APIs
    func insertPayment(username:String){
        if open() {
            // Transform the meal image to String
            let sql = "INSERT INTO " + TABLE_NAME + "(" + USERNAME + ")" + " VALUES (?)"
            if db!.executeUpdate(sql, withArgumentsIn: [username]) {
                os_log("The payment is insert to the database!")
            }
            else {
                os_log("Fail to insert the book!")
            }
        }
        else {
            os_log("Database is nil!")
        }
        close()
    }
    
    func readPaymentListAll() -> [Payment] {
        var payments = [Payment]()
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
                    let payment_id = results!.int(forColumn: PAYMENT_ID)
                    let username = results!.string(forColumn: USERNAME)
                    // Create a meal to contain the values
                    let payment = Payment(payment_id: Int(exactly: payment_id)!, username: username!)
                    payments.append(payment!)
                }
            }
        }
        else{
            os_log("Database is nil!")
        }
        close()
        return payments
    }

    func readPaymentList(username:String) -> [Payment] {
        var payments = [Payment]()
        if open() {
            var results: FMResultSet?
            let sql = "SELECT * FROM \(TABLE_NAME) WHERE \(USERNAME) = ?"
            // Query
            do {
                results = try db!.executeQuery(sql, values: [username])
            }
            catch {
                print("Fail to read data: \(error.localizedDescription)")
            }
            // Read data from the results
            if results != nil {
                while (results?.next())! {
                    let payment_id = results!.int(forColumn: PAYMENT_ID)
                    let username = results!.string(forColumn: USERNAME)
                    // Create a meal to contain the values
                    let payment = Payment(payment_id: Int(exactly: payment_id)!, username: username!)
                    payments.append(payment!)
                }
            }
        }
        else{
            os_log("Database is nil!")
        }
        close()
        return payments
    }
}
