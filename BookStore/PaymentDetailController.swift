//
//  PaymentDetailController.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit

class PaymentDetailController: UITableViewController {
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let book = Book(book_id: 1, book_name: "Sách một", author: "Tác giả một", price: 80000, image: UIImage(named: "Image1"), quantity: 1) {
            books += [book]
        }
        if let book = Book(book_id: 2, book_name: "Sách hai", author: "Tác giả hai", price: 120000, image: UIImage(named: "Image2"), quantity: 2) {
            books += [book]
        }
        if let book = Book(book_id: 3, book_name: "Sách ba", author: "Tác giả ba", price: 70000, image: UIImage(named: "Image3"), quantity: 3) {
            books += [book]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "PaymentDetailCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? PaymentDetailCell
        {
            let book = books[indexPath.row]
            cell.txtBookCode.text = String(book.book_id)
            cell.txtBookTitle.text = book.book_name
            cell.txtAuthor.text = book.author
            cell.txtPrice.text = String(book.price)
            cell.imgBook.image = book.image
            cell.txtTotalMoney.text = String(book.total_money)
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
