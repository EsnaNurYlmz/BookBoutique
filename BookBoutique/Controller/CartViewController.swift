//
//  CartViewController.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 13.08.2024.
//

import UIKit
import CoreData

class CartViewController: UIViewController {

    var cartList = [CartBook]()
    @IBOutlet weak var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cartTableView.dataSource = self
        cartTableView.delegate = self
        fetchCartBooks()
    }
    func fetchCartBooks() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<CartBook> = CartBook.fetchRequest()
            
            do {
                cartList = try context.fetch(fetchRequest)
                cartTableView.reloadData()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
}
extension CartViewController : UITableViewDelegate , UITableViewDataSource , CartTableViewCellDelegate 
{
    func didTapPurchaseButton() {
        let alert = UIAlertController(title: nil, message: "Ürün satın alındı", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = cartList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartHucre", for: indexPath) as! CartTableViewCell
        
        if let url = URL(string: "http://localhost:8080/image/find/\(book.bookImage ?? "")"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.bookImageView.image = UIImage(data: data ?? Data())
                }
            }
        }
        cell.bookName.text = book.bookName
        cell.bookPrice.text = book.bookPrice
        cell.delegate = self
        return cell
    }
   
    
}
