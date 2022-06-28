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
    
    func getRecipes(for ingredients: [String], completionHandler: @escaping (_ recipes: [Recipe]?, _ error: Error?) -> Void) {
        
        // Convert ingredients array to a single string
        let ingredientsAsString = ingredients.joined(separator: " ")
        
        let urlString = "\(EdamamApi.recipeSearchUrl)&q=\(ingredientsAsString)&time=\(minCokkingTime)&field=label&field=ingredients&field=totalTime&field=images"
        
        let networkService = NetworkService()
        
        networkService.makeRequest(urlString: urlString, method: EdamamApi.recipeSearchMethod) { data, error in
            
            if let error = error {
                //Check if errors
                
                completionHandler(nil, error)
            
                return
                
            }
            else {
                
                //Check if data is not nil
                guard let data = data else {
                    
                    completionHandler(nil, RecipeSearchError.noDataReceived)
                    
                    return
                    
                }

                //Check if data is of correct format
                guard let json = try? JSON(data: data) else {
                    
                    completionHandler(nil, RecipeSearchError.unexpectedDataFormat)
                    
                    return
                    
                }
                
                /// Array contaning all recipes and their details
                var recipes: [Recipe] = []
                
                //Check if at least one recipe has been found
                if json["count"] > 0 {
                    
                    for recipeDetail in json["hits"].arrayValue {
                        
                        let recipe = Recipe()
                        
                        // Store the recipe details
                        recipe.title = recipeDetail["recipe"]["label"].stringValue
                        recipe.imageLink = recipeDetail["recipe"]["images"]["REGULAR"]["url"].stringValue
                        recipe.cookingTime = recipeDetail["recipe"]["totalTime"].floatValue
                        
                        let ingredientDetails = recipeDetail["recipe"]["ingredients"].arrayValue

                        var ingredientNames: [String] = []
                        
                        var ingredientsMeasurements: [String] = []
                        
                        ingredientDetails.forEach { ingredient in

                            ingredientNames.append(ingredient["food"].stringValue)

                            ingredientsMeasurements.append(ingredient["text"].stringValue)

                        }
                        
                        recipe.ingredientNames = ingredientNames
                        
                        recipe.ingredientsMeasurements = ingredientsMeasurements
                        
                        recipes.append(recipe)
                        
                    }
                    
                    // Send the array of recipes to the closure
                    completionHandler(recipes, nil)
                }
                
                else {
                    
                    // Send an array contaning an empty dictionnary as the only element if no recipe has been found
                    completionHandler(nil, RecipeSearchError.noRecipeFound)
                }
                
                
            }
        }
    }
}
