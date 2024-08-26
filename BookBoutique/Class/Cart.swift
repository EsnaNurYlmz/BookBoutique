//
//  Cart.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 15.08.2024.
//

import Foundation

class Cart {
    static let shared = Cart()
    private init() {}

    var items: [Book] = []

    func add(book: Book) {
        items.append(book)
    }
}
