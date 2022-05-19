//
//  Book.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import Foundation
import UIKit

class Book {
    var book_id:Int
    var book_name:String
    var author:String
    var price:Int
    var image:UIImage?
    var quantity:Int
    var total_money:Int
    
    init?(book_id:Int, book_name:String, author:String, price:Int, image:UIImage?, quantity:Int, total_money:Int) {
        self.book_id = book_id
        self.book_name = book_name
        self.author = author
        self.price = price
        self.image = image
        self.quantity = quantity
        self.total_money = total_money
    }
}
