//
//  CartTableViewCell.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 13.08.2024.
//

import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func didTapPurchaseButton()
}

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    weak var delegate: CartTableViewCellDelegate?
    @IBOutlet weak var PriceStepper: UIStepper!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PriceStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)

    }

    @objc func stepperValueChanged(_ sender: UIStepper) {
            let pricePerItem = 20.0 
            let totalPrice = pricePerItem * sender.value
            bookPrice.text = "Fiyat: \(totalPrice) TL"
        }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    

    @IBAction func BuyButton(_ sender: UIButton) {
        delegate?.didTapPurchaseButton()
    }
}
