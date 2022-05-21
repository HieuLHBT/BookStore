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
        dal.readBookList(books: &books)
        if books.count == 0 {
            if let book = Book(book_id: 1, book_name: "Sách một", author: "Tác giả một", price: 80000, image: UIImage(named: "Image1"), quantity: 2) {
                books += [book]
                if dal.open() {
                    dal.insertBook(book: book)
                }
            }
        }
        navigationItem.leftBarButtonItem = editButtonItem
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
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
    @IBAction func unWindFormMealDetailController(segue:UIStoryboardSegue) {
        //Get soucre controller (MealDetailController)
        if let sourceController = segue.source as? BookDetailController {
            if let book = sourceController.book {
                //Indetifying update or add new meal
                switch navigationType {
                case .newBook:
                    //Add the new meal into the datasource: meals
                    books += [book]
                    //Add the new meal into the table view
                    let indexParth = IndexPath(row: books.count - 1, section: 0)
                    tableView.insertRows(at: [indexParth], with: .automatic)
                case .editBook:
                    //Get the position of selectd row
                    if let selecteIndexparthdRow = tableView.indexPathForSelectedRow {
                        //Update to data source
                        books[selecteIndexparthdRow.row] = book
                        //Reload the update meal to table view
                        tableView.reloadRows(at: [selecteIndexparthdRow], with: .automatic)
                    }
                    break
                }
            }
        }
    }

}
