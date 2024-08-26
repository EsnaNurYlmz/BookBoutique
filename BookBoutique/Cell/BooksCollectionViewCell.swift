//
//  BooksCollectionViewCell.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 13.08.2024.
//



import UIKit

protocol BooksCollectionViewCellDelegate: AnyObject {
    func didTapAddToCart(for cell: BooksCollectionViewCell)
}
class BooksCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: BooksCollectionViewCellDelegate?
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    
    @IBAction func CartButtonCell(_ sender: Any) {
        delegate?.didTapAddToCart(for: self)
    }
    
    
}
