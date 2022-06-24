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
                
                //Check at least one recipe has been found
                if json["count"] > 0 {
                    
                    // Remove the first empty dictionnary element from the array
                    recipes.removeFirst()
                    
                    for recipe in json["hits"].arrayValue {
                        
                        // Retrieve each recipe detail separately
                        let title = recipe["recipe"]["label"].stringValue
                        let imageLink = recipe["recipe"]["images"]["REGULAR"]["url"].stringValue
                        let ingredientsMeasurements = recipe["recipe"]["ingredientLines"].arrayValue
                        let ingredientDetails = recipe["recipe"]["ingredients"].arrayValue
                        let cookingTime = recipe["recipe"]["totalTime"].floatValue
                        
                        var ingredientNames: [Any] = []
                        
//                        let mockJson = JSON(ingredientDetails)
                        
//                        for (_,ingredient) in mockJson {
//                            print("hey")
//                            ingredientNames.append(ingredient["food"].stringValue)
//
//                        }
//
                        ingredientDetails.forEach { ingredient in

                            print("ingredient name: ", ingredient["food"].stringValue)

                            ingredientNames.append(ingredient["text"].stringValue)

                        }
                        
                        print("Count: ", ingredientNames.count)
                        
                        // Store the details of the recipe in a row of the array
                        recipeDetail["title"] = title
                        recipeDetail["imageLink"] = imageLink
                        recipeDetail["ingredientsMeasurements"] = ingredientsMeasurements
                        recipeDetail["ingredientNames"] = ingredientNames
                        recipeDetail["cookingTime"] = cookingTime
                        
                        // Store the recipe detail in the array
                        recipes.append(recipeDetail)
                    
                    }
                    
                    // Send the array of recipes to the closure
                    completionHandler(recipes, nil)
                }
                
                else {
                    
                    // Send an array contaning an empty dictionnary as the only element if no recipe has been found
                    completionHandler(recipes, nil)
                }
                
                
            }
        }
    }
}
