//
//  PaymentDetailController.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit

class PaymentDetailController: UITableViewController {
    @IBOutlet weak var txtPaymentid: UILabel!
    private var dalBooks = BookManagementDatabase()
    private var dalDetails = DetailDatabase()
    var details = [Detail]()
    var paymentid: Int?
    let formatter = NumberFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = NumberFormatter.Style.decimal
        details = dalDetails.readDetailList(paymentid: paymentid!)
        txtPaymentid.text = String(paymentid!)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "PaymentDetailCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? PaymentDetailCell
        {
            let detail = details[indexPath.row]
            let book = dalBooks.readBook(bookid: detail.book_id)
            cell.txtBookCode.text = String(book.book_id)
            cell.txtBookTitle.text = book.book_name
            cell.txtAuthor.text = book.author
            cell.txtPrice.text = formatter.string(from: book.price as NSNumber)!
            cell.imgBook.image = book.image
            cell.txtTotalMoney.text = formatter.string(from: (book.price * detail.quantity) as NSNumber)!
            cell.txtQuantity.text = String(detail.quantity)
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
