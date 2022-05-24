//
//  PaymentHistoryController.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit

class PaymentHistoryController: UITableViewController {
    private var dalPayments = PaymentDatabase()
    private var dalBooks = BookManagementDatabase()
    private var dalDetails = DetailDatabase()
    var payments = [Payment]()
    let formatter = NumberFormatter()
    var user: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = NumberFormatter.Style.decimal
        payments = dalPayments.readPaymentList(username: user!)
    }
    
    @IBAction func back(_ sender: Any) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identity = segue.identifier
//        if identity == "PaymentHistoryController" {
//            if let navigationController = navigationController {
//                navigationController.popViewController(animated: true)
//            }
//        }
        if identity == "PaymentDetailController" {
            if let selecteIndexparthdRow = tableView.indexPathForSelectedRow {
                //Get the selected form data source
                if let destinationController = segue.destination as? PaymentDetailController {
                    destinationController.paymentid = payments[selecteIndexparthdRow.row].payment_id
                    print(selecteIndexparthdRow.row)
                }
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return payments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "PaymentHistoryCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? PaymentHistoryCell
        {
            let payment = payments[indexPath.row]
            let details = dalDetails.readDetailList(paymentid: payment.payment_id)
            var sum: Int = 0
            for detail in details {
                let book = dalBooks.readBook(bookid: detail.book_id)
                let total = detail.quantity * book.price
                sum += total
            }
            cell.txtPaymentID.text = String(payment.payment_id)
            cell.txtAmountPaid.text = formatter.string(from: sum as NSNumber)!
            return cell
        }
        else {
            fatalError("Can't create the Cell")
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
