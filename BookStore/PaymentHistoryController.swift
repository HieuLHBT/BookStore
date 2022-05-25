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
    enum Controller {
        case list
        case cart
    }
    var controller: Controller = .list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.numberStyle = NumberFormatter.Style.decimal
        payments = dalPayments.readPaymentList(username: user!)
    }
    
    @IBAction func back(_ sender: Any) {
        switch controller {
        case .list:
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            }
        case .cart:
            //pop as kieu ve man hinh can khac null thi dung
            //Get the navigation controller
            if let navigationController = navigationController {
                navigationController.popViewController(animated: false)
                navigationController.popViewController(animated: true)
            }
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
            if let sender = sender as? UIButton { //sender all item prepare
                for cell in tableView.visibleCells {
                    let paymentcell = cell as? PaymentHistoryCell
                    if let detailcel = paymentcell?.getCell(button: sender) {
                        if let destinationController = segue.destination as? PaymentDetailController {
                            destinationController.paymentid = Int(detailcel.txtPaymentID.text!)
                            return
                        }
                       
                    }
//                    if (paymentcell?.btnDetail === sender) {
//                        if let destinationController = segue.destination as? PaymentDetailController {
//                            destinationController.paymentid = Int((paymentcell?.txtPaymentID.text)!)
//                        }
//                        return
//                    }
                }
            }
            
//            if let selecteIndexparthdRow = tableView.indexPathForSelectedRow {
//                //Get the selected form data source
//                if let destinationController = segue.destination as? PaymentDetailController {
//                    destinationController.paymentid = payments[selecteIndexparthdRow.row].payment_id
//                    print(selecteIndexparthdRow.row)
//                }
//            }
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

}
