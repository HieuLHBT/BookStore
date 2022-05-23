//
//  LoginController.swift
//  BookStore
//
//  Created by Hell King XIII on 23/05/2022.
//

import UIKit
import os.log

class LoginController: UIViewController {
    private var dalUser = UserDatabase()
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var btnSignin: UIButton!
    var check = "2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let users = dalUser.readUserList()
        if users.count == 0 {
            if let admin = User(username: "admin", password: "admin", email: "admin", check: "0")
            {
                if dalUser.signUp(user: admin) {
                    print("ok")
                }
            }
        }
    }
    
    @IBAction func enableSignin(_ sender: Any) {
        if (username.text != "") {
            btnSignin.isEnabled = true
        }
        else {
            btnSignin.isEnabled = false
        }
    }
    
    
    @IBAction func editUsername(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Username required!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in }
        if (username.text == "") {
            username.backgroundColor = UIColor.red
            alert.addAction(ok)
            self.present(alert, animated:true, completion: nil)
        }
        else {
            username.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func editPassword(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Password required!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in }
        if (password.text == "") {
            password.backgroundColor = UIColor.red
            alert.addAction(ok)
            self.present(alert, animated:true, completion: nil)
        }
        else {
            password.backgroundColor = UIColor.white
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identity = segue.identifier
        if identity != nil {
            let alert = UIAlertController(title: "Warning", message: "Wrong password or account!", preferredStyle: UIAlertController.Style.alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in }
            check = dalUser.checkLogin(username: username.text!, password: password.text!)
            if check == "2" {
                alert.addAction(ok)
                self.present(alert, animated:true, completion: nil)
                return
            }
            if let destinationController = segue.destination as? ListOfBooksController {
                destinationController.check = check
            }
        }
    }
}
