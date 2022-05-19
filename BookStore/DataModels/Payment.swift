//
//  Payment.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import Foundation
import UIKit

class Payment {
    var payment_id:Int
    var amount_paid:Int
    
    init?(payment_id:Int, amount_paid:Int) {
        self.payment_id = payment_id
        self.amount_paid = amount_paid
    }
}
