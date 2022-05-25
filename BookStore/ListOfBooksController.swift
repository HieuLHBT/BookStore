//
//  ListOfBooksTableViewController.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit

class ListOfBooksController: UITableViewController, UITextFieldDelegate {
    //MARK: properties
    var books = [Book]()
    private var dalBooks = BookManagementDatabase()
    private var dalCarts = CartDatabase()
    @IBOutlet weak var btnManage: UIBarButtonItem!
    @IBOutlet weak var btnCart: UIBarButtonItem!
    var check: String?
    var user: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        books = dalBooks.readBookList()
        if check == "0" {
            btnManage.isEnabled = true
        }
        else if check == "1" {
            btnManage.isEnabled = false
        }
        if dalCarts.readCartList().count == 0 {
            btnCart.isEnabled = false
        }
        else {
            btnCart.isEnabled = true
        }
    }
    
    @IBAction func logout(_ sender: Any) {
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
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "ListOfBooksCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? ListOfBooksCell
        {
            let book = books[indexPath.row]
            cell.txtBookCode.text = String(book.book_id)
            cell.txtBookTitle.text = book.book_name
            cell.txtAuthor.text = book.author
            cell.txtPrice.text = String(book.price)
            cell.imgBook.image = book.image
            cell.txtQuantity.text = String(book.quantity)
            return cell
        }
        else {
            fatalError("Can't create the Cell")
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identity = segue.identifier
        if identity == "CartsController" {
            if let destinationController = segue.destination as? CartsController {
                destinationController.user = user
            }
        }
        if identity == "HistoryController" {
            
            if let destinationController = segue.destination as? PaymentHistoryController {
                destinationController.user = user
                destinationController.controller = .list
            }
        }
    }
    
    @IBAction func unWindFormBookManagementController(segue:UIStoryboardSegue) {
        //Get soucre controller (MealDetailController)
        books = dalBooks.readBookList()
        tableView.reloadData()
    }
}
