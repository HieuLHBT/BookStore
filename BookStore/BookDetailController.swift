//
//  BookDetailController.swift
//  BookStore
//
//  Created by Hell King XIII on 21/05/2022.
//

import UIKit

class BookDetailController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var edtBookID: UITextField!
    @IBOutlet weak var edtBookName: UITextField!
    @IBOutlet weak var edtAuthor: UITextField!
    @IBOutlet weak var edtPrice: UITextField!
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var btnImport: UIButton!
    
    enum NavigationsType {
        case newBook
        case editBook
    }
    var navigationType:NavigationsType = .newBook
    
    //Variable to pass to meal list controller
    var book:Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        //Settup for the button corner
        btnImport.clipsToBounds = true
        btnImport.layer.cornerRadius = 10
        //Delegation of Texfield
        edtBookName.delegate = self
        edtAuthor.delegate = self
        edtPrice.delegate = self
        //Get edit meal from meail table view controller
        if let book = book {
            edtBookID.text = String(book.book_id)
            edtBookName.text = book.book_name
            edtAuthor.text = book.author
            edtPrice.text = String(book.price)
            imgBook.image = book.image
            navigationItem.title = book.book_name
        }
    }

    //MARK: TextField's Delegation Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hied the Keyboard
        edtBookName.resignFirstResponder()
        edtAuthor.resignFirstResponder()
        edtPrice.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.title = edtBookName.text!
    }
    
    
    //MARK: Image processing
    @IBAction func imageProcessing(_ sender: UITapGestureRecognizer) {
        //Hide the Keyboard
        edtBookName.resignFirstResponder()
        edtAuthor.resignFirstResponder()
        edtPrice.resignFirstResponder()
        //Create an object of UIImagePickerController
        let imagePickerController = UIImagePickerController();
        //Settup properties for the image picker object
        imagePickerController.sourceType = .photoLibrary
        //Delegation of image picker boject
        imagePickerController.delegate = self
        //Pass to the imagePicker controller Screen
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Image picker controller's Delagation Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imgBook.image = selectedImage
        }
        //Hide the image picker controller
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Hide the image picker controller and return the previous screen
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        switch navigationType {
        case .newBook:
            dismiss(animated: true, completion: nil)
        case .editBook:
            //pop as kieu ve man hinh can khac null thi dung
            //Get the navigation controller
            if let navigationController = navigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let book_id = Int(edtBookID.text ?? "0")
        let book_name = edtBookName.text ?? ""
        let author = edtAuthor.text ?? ""
        let price = Int(edtPrice.text ?? "0")
        let image = imgBook.image
        //Create the neal meal
        book = Book(book_id: book_id ?? 0, book_name: book_name, author: author, price: price ?? 0, image: image, quantity: 1)
    }
}
