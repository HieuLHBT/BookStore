//
//  CartsController.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit

class CartsController: UITableViewController {
    var carts = [Cart]()
    private var dalBooks = BookManagementDatabase()
    private var dalCarts = CartDatabase()
    @IBOutlet weak var cash: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carts = dalCarts.readCartList()
        cashCart()
    }
    
    func cashCart() {
        var sum: Int = 0
        let cashCarts = dalCarts.readCartList()
        for cart in cashCarts {
            let book = dalBooks.readBook(bookid: cart.book_id)
            let total = cart.quantity * book.price
            sum += total
        }
        cash.text = String(sum)
    }
    
    @IBAction func cashUpdate(_ sender: Any) {
        cashCart()
    }
    
    @IBAction func back(_ sender: Any) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    @IBAction func payment(_ sender: Any) {
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return carts.count
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?  {
        // add the action button you want to show when swiping on tableView's cell , in this case add the delete button.
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, sourceView, completionHandler) in
            dalCarts.deleteCart(cardid: carts[indexPath.row].cart_id)
            carts = dalCarts.readCartList()
            cashCart()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "CartsCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? CartsCell
        {
            let cart = carts[indexPath.row]
            let book = dalBooks.readBook(bookid: cart.book_id)
            cell.txtBookName.text = book.book_name
            cell.txtPrice.text = String(book.price)
            cell.txtQuantity.text = String(cart.quantity)
            cell.txtTotalMoney.text = String(book.price * cart.quantity)
            cell.imgBook.image = book.image
            cell.cartID  = cart.cart_id
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
