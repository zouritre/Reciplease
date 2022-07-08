//
//  FavoriteSearchService.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 28/06/2022.
//

import Foundation

class FavoriteSearchService {
    
    func getFavoriteRecipes(handler: @escaping (_ favorites: [Recipe]) -> Void) {
        
        //Query to be sent to the datastore
        let query = Favorite.query().fetch()
        
        //Array containing all recipes retrieved from datastore
        var favoriteRecipes: [Recipe] = []
        
        query.forEach{ favorite in
            
            guard let favorite = favorite as? Favorite else {
                handler(favoriteRecipes)
                return
            }
            
            guard let recipe = favorite.recipe else {
                handler(favoriteRecipes)
                return
            }
            
            (recipe.ingredientNames, recipe.ingredientsMeasurements) = decodedIngredients(from: recipe)
            
            favoriteRecipes.append(recipe)
            
        }
        handler(favoriteRecipes)
                
    }
    
    /// Add a recipe to datastore if it's not already in, otherwise removes it
    func updateFavorites(recipe: Recipe) {
        
        self.checkIsFavoriteRecipe(recipe: recipe) { [weak self] isFavorite in
            
            guard let self = self else {
                return
            }
            
            //Get from datastore recipes whose title matches the recipe selected by the user
            let query = Favorite.query().where("recipe.title = ?", parameters: ["\(recipe.title)"])
            
            switch isFavorite {
                
            case true:
                //Remove recipe from favorites
                query.fetch().remove()
                
            case false:
                (recipe.ingredientNames, recipe.ingredientsMeasurements) = self.encodedIngredients(from: recipe)
                
                //Add recipe to favorites
                Favorite(dictionary: ["recipe": recipe]).commit()
                
            }
            
        }
        
    }
    /// Check if the recipe is in the datastore favorite table and set the favorite button image accordingly
    /// - Parameter isFavorite: Handler returning a boolean indicating if the recipe was found in the datastore
    func checkIsFavoriteRecipe(recipe: Recipe, isFavorite: ((Bool) -> Void)? = nil) {
        
        let query = Favorite.query().where("recipe.title = ?", parameters: ["\(recipe.title)"])
        
        isFavorite?(query.count() >= 1)
        
    }
    
    func decodedIngredients(from recipe: Recipe) -> (decodedNames: [String], decodedMeasurements: [String]) {
        
        var ingredientNames: [String] = []
        
        var ingredientsMeasurements: [String] = []
        
        recipe.ingredientNames.forEach { name in

            ingredientNames.append(name.removingPercentEncoding!)

        }
        
        recipe.ingredientsMeasurements.forEach { measure in

            ingredientsMeasurements.append(measure.removingPercentEncoding!)

        }
        
        return (ingredientNames, ingredientsMeasurements)
        
    }
    
    func encodedIngredients(from recipe: Recipe) -> (encodedNames: [String], encodedMeasurements: [String]) {
        
        var ingredientNames: [String] = []
        
        var ingredientsMeasurements: [String] = []
        
        recipe.ingredientNames.forEach { name in

            ingredientNames.append(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

        }
        
        recipe.ingredientsMeasurements.forEach { measure in

            ingredientsMeasurements.append(measure.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

        }
        
        return (ingredientNames, ingredientsMeasurements)
        
    }
}
