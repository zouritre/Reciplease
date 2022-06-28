//
//  ormRecipe.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 27/06/2022.
//

import Foundation
import SharkORM

class Recipe: SRKObject {

    @objc dynamic var title: String = ""
    
    @objc dynamic var imageLink: String = ""
    
    @objc dynamic var cookingTime: Float = 0.0
    
    @objc dynamic var ingredientsMeasurements: [String] = [""]
    
    @objc dynamic var ingredientNames: [String] = [""]
    
}
