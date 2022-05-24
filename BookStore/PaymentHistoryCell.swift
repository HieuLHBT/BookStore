//
//  PaymentHistoryCell.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit

class PaymentHistoryCell: UITableViewCell {
    @IBOutlet weak var txtPaymentID: UITextField!
    @IBOutlet weak var txtAmountPaid: UITextField!
    @IBOutlet weak var btnDetail: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
