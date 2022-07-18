//
//  Favorite.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 28/06/2022.
//

import Foundation
import SharkORM

class Favorite: SRKObject {
    @objc dynamic var recipe: Recipe?
}
