//
//  FoodManagementDatabase.swift
//  FoodManagement2020
//
//  Created by Cuong Tieu-Kim on 1/18/21.
//

import Foundation
import UIKit
import os.log

class BookManagementDatabase {
    //MARK: Database Properties
    let dPath: String
    let DB_NAME: String = "Books.sqlite"
    let db: FMDatabase?
    
    //MARK: Tables's properties
    let TABLE_NAME: String = "books"
    let BOOK_ID: String = "_id"
    let BOOK_NAME: String = "name"
    let BOOK_AUTHOR: String = "author"
    let BOOK_PRICE: String = "price"
    let BOOK_IMAGE: String = "image"
    
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
            + BOOK_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, "
            + BOOK_NAME + " TEXT, "
            + BOOK_AUTHOR + " TEXT, "
            + BOOK_PRICE + " INTEGER, "
            + BOOK_IMAGE + " TEXT )"
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
    func insertBook(book: Book){
        if open() {
            // Transform the meal image to String
            let imageData: NSData = book.image!.pngData()! as NSData
            let bookImgageString = imageData.base64EncodedData(options: .lineLength64Characters)
            let sql = "INSERT INTO " + TABLE_NAME + "(" + BOOK_NAME + ", " + BOOK_AUTHOR + ", " + BOOK_PRICE + ", " + BOOK_IMAGE + ")" + " VALUES (?, ?, ?, ?)"
            if db!.executeUpdate(sql, withArgumentsIn: [book.book_name, book.author, book.price, bookImgageString]) {
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
    
    func deleteBook(book: Book){
        if open() {
            if db != nil {
                let sql = "DELETE FROM \(TABLE_NAME) WHERE \(BOOK_ID) = ?"
                do {
                    try db!.executeUpdate(sql, values: [book.book_id])
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
    
    func readBook(bookid: Int) -> Book {
        var book:Book?
        if open() {
            var results: FMResultSet?
            let sql = "SELECT * FROM \(TABLE_NAME) WHERE \(BOOK_ID) = ?"
            // Query
            do {
                results = try db!.executeQuery(sql, values: [bookid])
            }
            catch {
                print("Fail to read data: \(error.localizedDescription)")
            }
            // Read data from the results
            if results != nil {
                while (results?.next())! {
                    let book_id = results!.int(forColumn: BOOK_ID)
                    let book_name = results!.string(forColumn: BOOK_NAME)
                    let author = results!.string(forColumn: BOOK_AUTHOR)
                    let price = results!.int(forColumn: BOOK_PRICE)
                    let stringImage = results!.string(forColumn: BOOK_IMAGE)
                    // Transform string image to UIImage
                    let dataImage: Data = Data(base64Encoded: stringImage!, options: .ignoreUnknownCharacters)!
                    let bookImage = UIImage(data: dataImage)
                    // Create a meal to contain the values
                    book = Book(book_id: Int(book_id), book_name: book_name!, author: author!, price: Int(price), image: bookImage!, quantity: 1)
                    return book!
                }
            }
        }
        else{
            os_log("Database is nil!")
        }
        close()
        return book!
    }
    
    func readBookList() -> [Book] {
        var books = [Book]()
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
                    let book_id = results!.int(forColumn: BOOK_ID)
                    let book_name = results!.string(forColumn: BOOK_NAME)
                    let author = results!.string(forColumn: BOOK_AUTHOR)
                    let price = results!.int(forColumn: BOOK_PRICE)
                    let stringImage = results!.string(forColumn: BOOK_IMAGE)
                    // Transform string image to UIImage
                    let dataImage: Data = Data(base64Encoded: stringImage!, options: .ignoreUnknownCharacters)!
                    let bookImage = UIImage(data: dataImage)
                    // Create a meal to contain the values
                    let book = Book(book_id: Int(book_id), book_name: book_name!, author: author!, price: Int(price), image: bookImage!, quantity: 1)
                    books.append(book!)
                }
            }
        }
        else{
            os_log("Database is nil!")
        }
        close()
        return books
    }
    
    func updateBook(oldBook: Book, newBook: Book){
        if open() {
            if db != nil {
                let sql = "UPDATE \(TABLE_NAME) SET \(BOOK_NAME) = ?, \(BOOK_AUTHOR) = ?, \(BOOK_PRICE) = ?, \(BOOK_IMAGE) = ? WHERE \(BOOK_ID) = ?"
                // Transform image of new meal to String
                let newImageData: NSData = newBook.image!.pngData()! as NSData
                let newStringImage = newImageData.base64EncodedString(options: .lineLength64Characters)
                // Try to query the database
                do{
                    try db!.executeUpdate(sql, values: [newBook.book_name, newBook.author, newBook.price, newStringImage, oldBook.book_id])
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
