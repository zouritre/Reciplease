//
//  ormRecipe.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 27/06/2022.
//

import Foundation
import SharkORM
import SwiftyJSON

class Recipe: SRKObject {
    @objc dynamic var title: String = ""
    @objc dynamic var imageLink: String = ""
    @objc dynamic var cookingTime: String = ""
    @objc dynamic var ingredientsMeasurements: [String] = []
    @objc dynamic var ingredientNames: [String] = []
    
    convenience init(recipeDetail: JSON) {
        self.init()
        
        var propertiesSetter: [String:Any] = [:]
        
        propertiesSetter["title"] = recipeDetail["recipe"]["label"].stringValue
        propertiesSetter["imageLink"] = recipeDetail["recipe"]["images"]["REGULAR"]["url"].stringValue
        propertiesSetter["cookingTime"] = self.getTime(from: recipeDetail)
        (propertiesSetter["ingredientNames"], propertiesSetter["ingredientsMeasurements"]) = self.getIngredients(from: recipeDetail)
        
        self.init(dictionary: propertiesSetter)
    }
    
    /// Format minutes to HH:mm
    /// - Parameter recipeDetail: JSON contaning the time value of a recipe
    /// - Returns: A string formatted time
    private func getTime(from recipeDetail: JSON) -> String {
        let cookingTime = Int(recipeDetail["recipe"]["totalTime"].floatValue)
        let hours = Int(cookingTime/60)
        let minutes = Int(cookingTime%60)
        
        if hours >= 1 && minutes > 0{
            return "\(hours)h \(minutes)m"
        }
        
        else if hours >= 1 && minutes == 0 {
            return "\(hours)h"
        }
        else {
            return "\(minutes)m"
        }
    }
    
    /// Retrieve the ingredient names and measurements of a recipe
    /// - Parameter recipeDetail: JSON containing the ingredients of a recipd
    /// - Returns: A set containing every ingredient names and their measurements
    private func getIngredients(from recipeDetail: JSON) -> (ingredientNames: [String], ingredientsMeasurements: [String]) {
        let ingredientDetails = recipeDetail["recipe"]["ingredients"].arrayValue
        var ingredientNames: [String] = []
        var ingredientsMeasurements: [String] = []
        
        ingredientDetails.forEach { ingredient in
            ingredientNames.append(ingredient["food"].stringValue)
            ingredientsMeasurements.append(ingredient["text"].stringValue)
        }
        
        return (ingredientNames, ingredientsMeasurements)
    }
}
