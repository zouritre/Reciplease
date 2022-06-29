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
            print("we are here")
            favoriteRecipes.append(recipe)
        }
        print("or there")
        handler(favoriteRecipes)
                
    }
    
    /// Add a recipe to datastore if it's not already in, otherwise removes it
    func updateFavorites(recipe: Recipe?) {
        
        guard let recipe = recipe else {
            return
        }
        
        self.checkIsFavoriteRecipe(recipe: recipe) { isFavorite in
            
            //Get from datastore recipes whose title matches the recipe selected by the user
            let query = Favorite.query().where("recipe.title = ?", parameters: ["\(recipe.title)"])
            
            switch isFavorite {
                
            case true:
                //Remove recipe from favorites
                query.fetch().remove()
                
            case false:
                //Add recipe to favorites
                Favorite(dictionary: ["recipe": recipe]).commit()
            }
            
        }
        
    }
    /// Check if the recipe is in the datastore favorite table and set the favorite button image accordingly
    /// - Parameter isFavorite: Handler returning a boolean indicating if the recipe was found in the datastore
    func checkIsFavoriteRecipe(recipe: Recipe?, isFavorite: ((Bool) -> Void)? = nil) {
        
        guard let recipe = recipe else {
            return
        }
        
        let query = Favorite.query().where("recipe.title = ?", parameters: ["\(recipe.title)"])
        
        if query.count() >= 1 {
            //Recipe is already in favorites
            
            isFavorite?(true)
            
        }
        else {
            //Recipe is not in favorites
            
            isFavorite?(false)
            
        }
        
    }
}
