//
//  Book.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 13.08.2024.
//

import Foundation

class Book:Codable {
    
    var bookName : String?
    var bookName2 : String?
    var bookPrice : String?
    var bookImage : String?
    var authorName : String?
    var category : Category?
    
    init(bookName: String, bookPrice: String, bookImage: String, authorName: String, category: Category ) {
        self.bookName = bookName
        self.bookPrice = bookPrice
        self.bookImage = bookImage
        self.authorName = authorName
        self.category = category
    }
}

