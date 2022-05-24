//
//  Book.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import Foundation
import UIKit

class Detail {
    var book_id:Int
    var payment_id:Int
    var quantity:Int
    
    init?(book_id:Int, payment_id:Int, quantity:Int) {
        self.book_id = book_id
        self.payment_id = payment_id
        self.quantity = quantity
    }
}
