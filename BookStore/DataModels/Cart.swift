//
//  Book.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import Foundation
import UIKit

class Cart {
    var cart_id:Int
    var book_id:Int
    var quantity:Int
    
    init?(cart_id:Int, book_id:Int, quantity:Int) {
        self.cart_id = cart_id
        self.book_id = book_id
        self.quantity = quantity
    }
}
