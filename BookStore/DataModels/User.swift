//
//  Book.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import Foundation
import UIKit

class User {
    var username:String
    var password:String
    var email:String
    var check:String
    
    init?(username:String, password:String, email:String, check:String) {
        self.username = username
        self.password = password
        self.email = email
        self.check = check
    }
}
