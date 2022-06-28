//
//  Favorite.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 28/06/2022.
//

import Foundation
import SharkORM

class Favorite: SRKObject {

    @objc dynamic var recipe: Recipe = Recipe()
    
    override func entityWillInsert() -> Bool {
        print("inserting ", recipe.title)
        return true
    }
    
    override func entityDidInsert() {
        print("did insert ", recipe.title)
    }
    
    override func entityDidDelete() {
        print("did remove ", recipe.title)
    }

}
