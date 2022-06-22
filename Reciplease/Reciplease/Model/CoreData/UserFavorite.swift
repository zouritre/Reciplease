//
//  UserFavorite.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 22/06/2022.
//

import Foundation
import SharkORM

// Create entity named UserFavorite in data model with defined properties as attributes
class UserFavorite: SRKObject {

@objc dynamic var title: String?
@objc dynamic var age: Int = 0
@objc dynamic var height: Float = 0

// add a one->many relationship from the Person entity to the Department entity.
//@objc dynamic var department: Department?

}
