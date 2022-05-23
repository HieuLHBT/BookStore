//
//  SignupController.swift
//  BookStore
//
//  Created by Hell King XIII on 23/05/2022.
//

import UIKit

class SignupController: UIViewController {
    private var dal = UserDatabase()
    @IBOutlet weak var edtUsername: UITextField!
    @IBOutlet weak var edtPassword: UITextField!
    @IBOutlet weak var edtRepeat: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    @IBAction func editUsername(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Username required!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in }
        if (edtUsername.text == "") {
            edtUsername.backgroundColor = UIColor.red
            alert.addAction(ok)
            self.present(alert, animated:true, completion: nil)
        }
        else {
            edtUsername.backgroundColor = UIColor.white
        }
    }
    @IBAction func enabledSignup(_ sender: Any) {
        if (edtUsername.text != "") {
            btnSignup.isEnabled = true
        }
        else {
            btnSignup.isEnabled = false
        }
    }
    
    @IBAction func editPassword(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Password required!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in }
        if (edtPassword.text == "") {
            edtPassword.backgroundColor = UIColor.red
            alert.addAction(ok)
            self.present(alert, animated:true, completion: nil)
        }
        else {
            edtPassword.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func enabledRepeat(_ sender: Any) {
        if (edtPassword.text != "") {
            edtRepeat.isEnabled = true
        }
        else {
            edtRepeat.isEnabled = false
        }
    }
    
    @IBAction func editRepeat(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Reapeat password required!", preferredStyle: UIAlertController.Style.alert)
        let syntax = UIAlertController(title: "Warning", message: "Syntax error!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in }
        if (edtRepeat.text == "") {
            edtRepeat.backgroundColor = UIColor.red
            alert.addAction(ok)
            self.present(alert, animated:true, completion: nil)
        }
        else if (edtRepeat.text != edtPassword.text) {
            edtRepeat.backgroundColor = UIColor.red
            syntax.addAction(ok)
            self.present(syntax, animated:true, completion: nil)
        }
        else {
            edtRepeat.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func editEmail(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Email required!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in }
        if (edtEmail.text == "") {
            edtEmail.backgroundColor = UIColor.red
            alert.addAction(ok)
            self.present(alert, animated:true, completion: nil)
        }
        else {
            edtEmail.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func signup(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Have not entered information!", preferredStyle: UIAlertController.Style.alert)
        let error = UIAlertController(title: "Warning", message: "Error!", preferredStyle: UIAlertController.Style.alert)
        let signup = UIAlertController(title: "Notification", message: "Create account success!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in }
        if (edtUsername.text == "" || edtPassword.text == "" || edtRepeat.text == "" || edtEmail.text == "") {
            alert.addAction(ok)
            self.present(alert, animated:true, completion: nil)
            return
        }
        let user = User(username: edtUsername.text!, password: edtPassword.text!, email: edtEmail.text!, check: "1")
        if !dal.signUp(user: user!) {
            error.addAction(ok)
            self.present(error, animated:true, completion: nil)
            return
        }
        else {
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) -> Void in
                if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            }})
            signup.addAction(ok)
            self.present(signup, animated:true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
