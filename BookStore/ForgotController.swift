//
//  ForgotController.swift
//  BookStore
//
//  Created by Hell King XIII on 23/05/2022.
//

import UIKit

class ForgotController: UIViewController {
    private var dalUser = UserDatabase()
    @IBOutlet weak var edtUsername: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var btnReset: UIButton!
    
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
    
    @IBAction func enabledReset(_ sender: Any) {
        if (edtUsername.text != "") {
            btnReset.isEnabled = true
        }
        else {
            btnReset.isEnabled = false
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
    
    @IBAction func reset(_ sender: Any) {
        let alert = UIAlertController(title: "Warning", message: "Enter the wrong account or registered email!", preferredStyle: UIAlertController.Style.alert)
        let reset = UIAlertController(title: "Notification", message: "Password reset successful!", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction) in }
        if dalUser.forgotPassword(username: edtUsername.text!, email: edtEmail.text!) {
            reset.addAction(ok)
            self.present(reset, animated:true, completion: nil)
        }
        else {
            alert.addAction(ok)
            self.present(alert, animated:true, completion: nil)
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
