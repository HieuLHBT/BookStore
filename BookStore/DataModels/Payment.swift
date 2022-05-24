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
    var username:String
    
    init?(payment_id:Int, username:String) {
        self.payment_id = payment_id
        self.username = username
    }
}
