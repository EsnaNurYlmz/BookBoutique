//
//  Category.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 8.08.2024.
//

import Foundation

class Category:Codable {
    
    var categoryName : String?
    var categoryId : String?
    
    init(categoryName: String ,  categoryId: String ) {
        self.categoryName = categoryName
        self.categoryId = categoryId
    }
    
}
