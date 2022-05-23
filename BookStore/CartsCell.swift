//
//  CartsTableViewCell.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit

class CartsCell: UITableViewCell {
    @IBOutlet weak var txtBookName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtTotalMoney: UITextField!
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var btnAdd: UIButton!
    private var dalCarts = CartDatabase()
    var cartID: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func add(_ sender: Any) {
        let quantity = (Int(txtQuantity.text ?? "0") ?? 0) + 1
        let price = Int(txtPrice.text ?? "0") ?? 0
        txtQuantity.text = String(quantity)
        txtTotalMoney.text = String(quantity * price)
        dalCarts.updateCart(cartid: cartID!, quantity: quantity)
    }
    
    @IBAction func apart(_ sender: Any) {
        let quantity = (Int(txtQuantity.text ?? "0") ?? 0) - 1
        let price = Int(txtPrice.text ?? "0") ?? 0
        if quantity < 1 {
            return
        }
        txtQuantity.text = String(quantity)
        txtTotalMoney.text = String(quantity * price)
        dalCarts.updateCart(cartid: cartID!, quantity: quantity)
    }
    
}
