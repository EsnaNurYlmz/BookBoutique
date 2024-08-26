//
//  FavoritesViewController.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 8.08.2024.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {

    @IBOutlet weak var FavoriteCollectionView: UICollectionView!
    var favoriteBooks = [FavoriteBook]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        FavoriteCollectionView.dataSource = self
        FavoriteCollectionView.delegate = self
        fetchFavoriteBooks()
    }
    func fetchFavoriteBooks() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<FavoriteBook> = FavoriteBook.fetchRequest()
            
            do {
                favoriteBooks = try context.fetch(fetchRequest)
                FavoriteCollectionView.reloadData()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
}
extension FavoritesViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteBooks.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesHucre", for: indexPath) as! FavoritesCollectionViewCell
                let favoriteBook = favoriteBooks[indexPath.row]
                
                cell.bookName.text = favoriteBook.bookName
                cell.bookPrice.text = favoriteBook.bookPrice
                
                if let url = URL(string: "http://localhost:8080/image/find/\(favoriteBook.bookImage ?? "")") {
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url)
                        DispatchQueue.main.async {
                            cell.bookImageView.image = UIImage(data: data ?? Data())
                        }
                    }
                }
     
                return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFavDetails", sender: indexPath.row)
    }
}

