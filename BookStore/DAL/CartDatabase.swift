//
//  FoodManagementDatabase.swift
//  FoodManagement2020
//
//  Created by Cuong Tieu-Kim on 1/18/21.
//

import Foundation
import UIKit
import os.log

class CartDatabase {
    //MARK: Database Properties
    let dPath: String
    let DB_NAME: String = "Books.sqlite"
    let db: FMDatabase?
    
    //MARK: Tables's properties
    let TABLE_NAME: String = "carts"
    let CART_ID: String = "_id"
    let BOOK_ID: String = "bookid"
    let QUANTITY: String = "quantity"
    
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
            + CART_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, "
            + BOOK_ID + " INTEGER, "
            + QUANTITY + " INTEGER) "
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
    func insertCart(bookid: Int, quantity: Int){
        if open() {
            // Transform the meal image to String
            let sql = "INSERT INTO " + TABLE_NAME + "(" + BOOK_ID + ", " + QUANTITY + ")" + " VALUES (?, ?)"
            if db!.executeUpdate(sql, withArgumentsIn: [bookid, quantity]) {
                os_log("The book is insert to the database!")
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
    
    func deleteCart(cardid: Int){
        if open() {
            if db != nil {
                let sql = "DELETE FROM \(TABLE_NAME) WHERE \(CART_ID) = ?"
                do {
                    try db!.executeUpdate(sql, values: [cardid])
                    os_log("The book is deleted!")
                }
                catch {
                    os_log("Fail to delete the book!")
                }
            }
            else {
                os_log("Database is nil!")
            }
        }
        close()
    }
    func readCartList() -> [Cart] {
        var carts = [Cart]()
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
                    let cart_id = results!.int(forColumn: CART_ID)
                    let book_id = results!.int(forColumn: BOOK_ID)
                    let quantity = results!.int(forColumn: QUANTITY)
                    // Create a meal to contain the values
                    let cart = Cart(cart_id: Int(cart_id), book_id: Int(book_id), quantity: Int(quantity))
                    carts.append(cart!)
                }
            }
        }
        else{
            os_log("Database is nil!")
        }
        close()
        return carts
    }
    
    func updateCart(cartid: Int, quantity: Int){
        if open() {
            if db != nil {
                let sql = "UPDATE \(TABLE_NAME) SET \(QUANTITY) = ? WHERE \(CART_ID) = ?"
                // Try to query the database
                do{
                    try db!.executeUpdate(sql, values: [quantity, cartid])
                    os_log("Successful to update the book!")
                }
                catch{
                    print("Fail to update the book: \(error.localizedDescription)")
                }
            }
            else {
                os_log("Database is nil!")
            }
        }
        close()
    }
}
