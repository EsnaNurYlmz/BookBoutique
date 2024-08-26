//
//  FavoriteBook+CoreDataProperties.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 15.08.2024.
//
//

import Foundation
import CoreData


extension FavoriteBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteBook> {
        return NSFetchRequest<FavoriteBook>(entityName: "FavoriteBook")
    }

    @NSManaged public var bookName: String?
    @NSManaged public var authorName: String?
    @NSManaged public var bookImage: String?
    @NSManaged public var bookPrice: String?

}

extension FavoriteBook : Identifiable {

}
