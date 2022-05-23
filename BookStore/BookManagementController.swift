//
//  BookTableViewController.swift
//  BookStore
//
//  Created by Hell King XIII on 08/05/2022.
//

import UIKit

class BookManagementController: UITableViewController {
    var books = [Book]()
    private var dal = BookManagementDatabase()
    enum NavigationsType {
        case newBook
        case editBook
    }
    var navigationType:NavigationsType = .newBook
    
    override func viewDidLoad() {
        super.viewDidLoad()
        books = dal.readBookList()
        if books.count == 0 {
            if let book = Book(book_id: 1, book_name: "Sách một", author: "Tác giả một", price: 80000, image: UIImage(named: "Image1"), quantity: 2) {
                dal.insertBook(book: book)
                books = dal.readBookList()
            }
        }
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
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "BookManagementCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? BookManagementCell
        {
            let book = books[indexPath.row]
            cell.txtBookCode.text = String(book.book_id)
            cell.txtBookTitle.text = book.book_name
            cell.txtAuthor.text = book.author
            cell.txtPrice.text = String(book.price)
            cell.imgBook.image = book.image
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?  {
        // add the action button you want to show when swiping on tableView's cell , in this case add the delete button.
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self] (action, sourceView, completionHandler) in
            dal.deleteBook(book: books[indexPath.row])
            books = dal.readBookList()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let segueName = segue.identifier {
            switch segueName {
            case "newBook":
                navigationType = .newBook
                if let destinationController = segue.destination as? BookDetailController {
                    destinationController.navigationType = .newBook
                }
            case "editBook":
                navigationType = .editBook
                //Get the selected meal
                if let selecteIndexparthdRow = tableView.indexPathForSelectedRow {
                    //Get the selected form data source
                    if let destinationController = segue.destination as? BookDetailController {
                        destinationController.book = books[selecteIndexparthdRow.row]
                        destinationController.navigationType = .editBook
                    }
                }
            default:
                break
            }
        }
    }
    
    
    // Create unWind to return form MealDetailController
    @IBAction func unWindFormBookDetailController(segue:UIStoryboardSegue) {
        //Get soucre controller (MealDetailController)
        if let sourceController = segue.source as? BookDetailController {
            if let book = sourceController.book {
                //Indetifying update or add new meal
                switch navigationType {
                case .newBook:
                    //Add the new meal into the datasource: meals
                    dal.insertBook(book: book)
                    books = dal.readBookList()
                    //Add the new meal into the table view
                    let indexParth = IndexPath(row: books.count - 1, section: 0)
                    tableView.insertRows(at: [indexParth], with: .automatic)
                case .editBook:
                    //Get the position of selectd row
                    if let selecteIndexparthdRow = tableView.indexPathForSelectedRow {
                        //Update to data source
                        dal.updateBook(oldBook: books[selecteIndexparthdRow.row], newBook: book)
                        books = dal.readBookList()
                        //Reload the update meal to table view
                        tableView.reloadRows(at: [selecteIndexparthdRow], with: .automatic)
                    }
                }
            }
        }
    }
}
