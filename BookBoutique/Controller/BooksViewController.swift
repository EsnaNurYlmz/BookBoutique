//
//  BooksViewController.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 13.08.2024.
//

import UIKit

class BooksViewController: UIViewController {

    @IBOutlet weak var BooksCollectionView: UICollectionView!
    @IBOutlet weak var BooksSearchBar: UISearchBar!
    var categories:Category?
    var bookList = [Book]()
    let cart = BookBoutique.Cart.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BooksCollectionView.dataSource = self
        BooksCollectionView.delegate = self
        
        let design :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.BooksCollectionView.frame.size.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let cellWidth = (width-30)/2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.7)
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        BooksCollectionView.collectionViewLayout = design
        
        if let c = categories {
            if let cId = Int(c.categoryId!){
                navigationItem.title = c.categoryName
                booksByCategoriID(categoryId: cId)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        let VC = segue.destination as! BookDetailsViewController
        VC.books = bookList[index!]
    }
    func booksByCategoriID(categoryId:Int){
        var request = URLRequest(url: URL(string: "http://localhost:8080/film/findCategoryFilms")!)
        request.httpMethod = "POST"
        let postString = "categoryId=\(categoryId)"
        request.httpBody = postString.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { data , response , error in
            if error != nil || data == nil {
                print("Error")
                return
            }
            do{
                let response = try JSONDecoder().decode(BookResponse.self, from: data!)
                if let getBookList = response.books {
                    self.bookList = getBookList
                }
                DispatchQueue.main.async {
                    self.BooksCollectionView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    @IBAction func Cart(_ sender: Any) {
        performSegue(withIdentifier: "toBookCart", sender: nil)
    }
}
extension BooksViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let book = bookList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksHucre", for: indexPath) as! BooksCollectionViewCell
        cell.bookName.text = book.bookName
        cell.bookPrice.text = book.bookPrice
        
        if let url = URL(string: "http://localhost:8080/image/find/\(book.bookImage!)"){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.bookImageView.image = UIImage(data: data ?? Data())
                }
            }
        }
        cell.bookImageView.image = UIImage(named: book.bookImage!)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toBookDetails", sender: indexPath.row)
    }
    
    func didTapAddToCart(for cell: BooksCollectionViewCell) {
            guard let indexPath = BooksCollectionView.indexPath(for: cell) else { return }
            let selectedBook = bookList[indexPath.row]
            addToCart(book: selectedBook)
        }
    func addToCart(book: Book) {
            cart.add(book: book)
            
            let alert = UIAlertController(title: nil, message: "Sepete eklendi", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            performSegue(withIdentifier: "toBookCart", sender: self)
        }
    
}
