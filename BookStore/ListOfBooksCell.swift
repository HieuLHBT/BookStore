//
//  ListOfBooksTableViewCell.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit

class ListOfBooksCell: UITableViewCell {
    //MARK: Prooerties
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var txtBookCode: UITextField!
    @IBOutlet weak var txtBookTitle: UITextField!
    @IBOutlet weak var txtAuthor: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var btnAddToBasket: UIButton!
    private var dalBooks = BookManagementDatabase()
    private var dalCarts = CartDatabase()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        let book_id = Int(txtBookCode.text ?? "0")
        let quantity = Int(txtQuantity.text ?? "0")
        let cashCarts = dalCarts.readCartList()
        var check = false
        for cart in cashCarts {
            if (cart.book_id == book_id) {
                let sum = cart.quantity + quantity!
                dalCarts.updateCart(cartid: cart.cart_id, quantity: sum)
                check = true
                break
            }
        }
        if !check {
            dalCarts.insertCart(bookid: book_id ?? 0, quantity: quantity ?? 0)
        }
    }
}
