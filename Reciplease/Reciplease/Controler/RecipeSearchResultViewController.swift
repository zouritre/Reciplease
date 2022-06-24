//
//  RecipeSearchResultViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 23/06/2022.
//

import UIKit

class RecipeSearchResultViewController: UIViewController {

    /// Ingredients chosen by the user
    var ingredients: [String] = []
    
    /// Recipes retrieved from API according to user selected ingredients
    var recipes: [[String : Any]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getRecipes()
        
    }
    
    @IBOutlet weak var resultLoadingIndicator: UIActivityIndicatorView!
    
    func getRecipes() {
        
        RecipeSearchService().getRecipes(for: ingredients) { [weak self] recipes, error in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                
                // Check if there's error in response
                if let error = error {
                    
                    self.alert(message: error)
                }
                else {
                    
                    // Check if there's data in response
                    guard let recipes = recipes else {
                        
                        self.alert(message: "No data received from server")
                        
                        return
                    
                    }
                    
                    self.recipes = recipes
                    
                    self.resultLoadingIndicator.isHidden = true
                    
                    recipes.forEach { recipe in

                        guard let title = recipe["title"] else {
                            print("found nil")
                            return
                        }

                        guard let ingredientsMeasurements = recipe["ingredientsMeasurements"] else {
                            print("found nil")
                            return
                        }

                        print("\(title) \n\(ingredientsMeasurements) ")

                    }
                }
            }
        }
    }

}
