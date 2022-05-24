//
//  CartsTableViewCell.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit
import os.log

class CartsCell: UITableViewCell {
    @IBOutlet weak var txtBookName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtTotalMoney: UITextField!
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var btnAdd: UIButton!
    private var dalCarts = CartDatabase()
    var cartID: Int?
    let formatter = NumberFormatter()
    var priceBook: Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func add(_ sender: Any) {
        formatter.numberStyle = NumberFormatter.Style.decimal
        let quantity = (Int(txtQuantity.text ?? "0") ?? 0) + 1
        txtQuantity.text = String(quantity)
        txtTotalMoney.text = formatter.string(from: (quantity * priceBook!) as NSNumber)!
        dalCarts.updateCart(cartid: cartID!, quantity: quantity)
    }
    
    @IBAction func apart(_ sender: Any) {
        let quantity = (Int(txtQuantity.text ?? "0") ?? 0) - 1
        if quantity < 1 {
            return
        }
        txtQuantity.text = String(quantity)
        txtTotalMoney.text = formatter.string(from: (quantity * priceBook!) as NSNumber)!
        dalCarts.updateCart(cartid: cartID!, quantity: quantity)
    }
    
}
