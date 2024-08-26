//
//  Favorite.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 22.08.2024.
//

import Foundation

class CartFav {
    static let shared = CartFav()
    private init() {}

    var items: [Book] = []

    func add(bookFav: Book) {
        items.append(bookFav)
    }
}
