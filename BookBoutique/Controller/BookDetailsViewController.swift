//
//  BookDetailsViewController.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 13.08.2024.
//

import UIKit
import CoreData

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    var books : Book?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let products = books {
            if let url = URL(string: "http://localhost:8080/image/find/\(products.bookImage!)"){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.bookImageView.image = UIImage(data: data ?? Data())
                    }
                }
            }
            bookName.text = products.bookName
            authorName.text = products.authorName
            bookPrice.text = products.bookPrice
        }
    }
    
    @IBAction func favoriteBook(_ sender: Any) {
        
        guard let product = books else { return }
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
               
                let favoriteBook = FavoriteBook(context: context)
                favoriteBook.bookName = product.bookName
                favoriteBook.bookImage = product.bookImage
                favoriteBook.bookPrice = product.bookPrice
                
                do {
                    try context.save()
                    
                    let alert = UIAlertController(title: nil, message: "Favorilere eklendi", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
    }
    
    @IBAction func goToCart(_ sender: Any) {
        performSegue(withIdentifier: "toCart", sender: nil)
    }
    
    @IBAction func addToCart(_ sender: Any) {
        
        guard let product = books else { return }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
       
        let cartbook = CartBook(context: context)
        cartbook.bookImage = product.bookImage
        cartbook.bookName = product.bookName
        cartbook.bookPrice = product.bookPrice
        do {
            try context.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
   
    
}
