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
    private var dalPayments = PaymentDatabase()
    private var dalDetails = DetailDatabase()
    @IBOutlet weak var cash: UILabel!
    @IBOutlet weak var btnPayment: UIButton!
    var user: String?
    let formatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = NumberFormatter.Style.decimal
        carts = dalCarts.readCartList()
        if carts.count != 0 {
            btnPayment.isEnabled = true
        }
        else {
            btnPayment.isEnabled = false
        }
        cashCart()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identity = segue.identifier
        if identity == "PaymentHistoryController" {
            carts = dalCarts.readCartList()
            if carts.count != 0 {
                dalPayments.insertPayment(username: user!)
                let payments = dalPayments.readPaymentListAll()
                let paymentid = payments[payments.count - 1].payment_id
                for cart in carts {
                    dalDetails.insertDetail(bookid: cart.book_id, paymentid: paymentid, quantity: cart.quantity)
                }
                dalCarts.deleteAllCart()
                if let destinationController = segue.destination as? PaymentHistoryController {
                    destinationController.user = user
                    destinationController.controller = .cart
                }
            }
        }
    }
    
    func cashCart() {
        var sum: Int = 0
        let cashCarts = dalCarts.readCartList()
        for cart in cashCarts {
            let book = dalBooks.readBook(bookid: cart.book_id)
            let total = cart.quantity * book.price
            sum += total
        }
        cash.text = formatter.string(from: sum as NSNumber)!
    }
    
    @IBAction func cashUpdate(_ sender: Any) {
        cashCart()
    }
    
    @IBAction func back(_ sender: Any) {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
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
            if carts.count == 0 {
                btnPayment.isEnabled = false
            }
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
            cell.txtPrice.text = formatter.string(from: book.price as NSNumber)!
            cell.txtQuantity.text = String(cart.quantity)
            cell.txtTotalMoney.text = formatter.string(from: (book.price * cart.quantity) as NSNumber)!
            cell.imgBook.image = book.image
            cell.cartID  = cart.cart_id
            cell.priceBook = book.price
            return cell
        }
        else {
            fatalError("Can't create the Cell")
        }
    }

}
