//
//  RecipeSearchService.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 23/06/2022.
//

import Foundation
import SwiftyJSON

class RecipeSearchService {
    
    private var minCokkingTime = "1-1000"
    
    func getRecipes(for ingredients: [String], completionHandler: @escaping (_ recipes: [[String: Any]]?, _ errorDescription: String?) -> Void) {
        
        // Convert ingredients array to a single string
        let ingredientsAsString = ingredients.joined(separator: " ")
        
        let urlString = "\(EdamamApi.recipeSearchUrl)&q=\(ingredientsAsString)&time=\(minCokkingTime)&field=label&field=ingredientLines&field=totalTime&field=images"
        
        NetworkService.shared.makeRequest(urlString: urlString, method: EdamamApi.recipeSearchMethod) { data, errorDescription in
            
            if let errorDescription = errorDescription {
                //Check if errors
                
                completionHandler(nil, errorDescription)
            
                return
                
            }
            else {
                
                //Check if data is not nil
                guard let data = data else {
                    
                    completionHandler(nil, "No data received")
                    
                    return
                    
                }

                //Check if data is of correct format
                guard let json = try? JSON(data: data) else {
                    
                    completionHandler(nil, "Couldn't decode server response")
                    
                    return
                    
                }
                
                /// Dictionnary contaning a recipe details
                var recipeDetail: [String: Any] = [:]
                
                /// Array contaning all recipes and their details
                var recipes: [[String: Any]] = [[:]]
                
                for recipe in json["hits"].arrayValue {
                    
                    // Retrieve each recipe detail separatly
                    let title = recipe["recipe"]["label"].stringValue
                    let imageLink = recipe["recipe"]["images"]["REGULAR"]["url"].stringValue
                    let ingredients = recipe["recipe"]["ingredientLines"].arrayValue
                    let cookingTime = recipe["recipe"]["totalTime"].floatValue
                    
                    // Store the details of the recipe in a row of the array
                    recipeDetail["title"] = title
                    recipeDetail["imageLink"] = imageLink
                    recipeDetail["ingredients"] = ingredients
                    recipeDetail["cookingTime"] = cookingTime
                    
                    // Store the recipe detail in the array
                    recipes.append(recipeDetail)
                
                }
                
                // Send the array of recipes to the closure
                completionHandler(recipes, nil)
                
            }
        }
    }
}
