//
//  ViewController.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 6.08.2024.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var newBookCollectionView: UICollectionView!
    @IBOutlet weak var advertCollectionView: UICollectionView!
    @IBOutlet weak var FeaturedBooksCollectionView: UICollectionView!
    
    let advertImage = ["resim9","resim8","resim6","resim7","reklam1","reklam2"]
    let BooksImage = ["book1","book4","book3","book5","book6","book7","book8","book9"]
    let newBookImage = ["b1","b2","b3","b4","b5","b6","b7","b8","b9","b10","b11","b12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advertCollectionView.delegate = self
        advertCollectionView.dataSource = self
        
        FeaturedBooksCollectionView.dataSource  = self
        FeaturedBooksCollectionView.delegate = self
        
        newBookCollectionView.dataSource = self
        newBookCollectionView.delegate = self
        
        if let layout = advertCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
       advertCollectionView.isPagingEnabled = true
        
        if let layout = FeaturedBooksCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        if let layout = newBookCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
    }
    
    @IBAction func category(_ sender: Any) {
        performSegue(withIdentifier: "toCategory", sender: nil)
    }
    
    @IBAction func favorite(_ sender: Any) {
        performSegue(withIdentifier: "toFavorite", sender: nil)
    }
    
    @IBAction func login(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    @IBAction func cart(_ sender: Any) {
        performSegue(withIdentifier: "goToCart", sender: nil)
    }
}

extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == advertCollectionView {
            return advertImage.count
        }else if collectionView == FeaturedBooksCollectionView{
            return BooksImage.count
        }
        else if collectionView == newBookCollectionView{
            return newBookImage.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == advertCollectionView {
            let cell = advertCollectionView.dequeueReusableCell(withReuseIdentifier: "advertHucre", for: indexPath) as! advertCollectionViewCell
                    cell.advertImage.image = UIImage(named: advertImage[indexPath.item])
                    return cell
        }else if collectionView == FeaturedBooksCollectionView{
            let cell = FeaturedBooksCollectionView.dequeueReusableCell(withReuseIdentifier: "BooksHucre", for: indexPath) as! FeaturedBooksCollectionViewCell
                    cell.BooksImage.image = UIImage(named: BooksImage[indexPath.item])
                    return cell
        }else if collectionView == newBookCollectionView {
            let cell = newBookCollectionView.dequeueReusableCell(withReuseIdentifier: "newBookHucre", for: indexPath) as! newBookCollectionViewCell
                    cell.newBookImage.image = UIImage(named: newBookImage[indexPath.item])
                    return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == advertCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

        }else if collectionView == FeaturedBooksCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

        }else if collectionView == newBookCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        return CGSize.zero
    }
}

