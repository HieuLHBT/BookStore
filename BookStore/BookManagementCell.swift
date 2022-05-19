//
//  BookManagementTableViewCell.swift
//  BookStore
//
//  Created by Hell King XIII on 19/05/2022.
//

import UIKit

class BookManagementCell: UITableViewCell {
    //MARK: Prooerties
    @IBOutlet weak var txtBookCode: UITextField!
    @IBOutlet weak var txtBookTitle: UITextField!
    @IBOutlet weak var txtAuthor: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var imgBook: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
