//
//  RecipeSearchViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 21/06/2022.
//

import UIKit
import SharkORM

class RecipeSearchViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        RecipeSearchService().getRecipes(for: ["Apple", "peanut"]) { recipes, error in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    
                    self.alert(message: error)
                }
                else {
                    
                    guard let recipes = recipes else {
                        
                        self.alert(message: "No recipe found")
                        
                        return
                    
                    }
                    
                    recipes.forEach { recipe in
                        
                        guard let title = recipe["title"] else {
                            print("found nil")
                            return
                        }
                        guard let cookingTime = recipe["cookingTime"] else {
                            print("found nil")
                            return
                        }
                        
                        print("\(title) \n\(cookingTime) ")
                        
                    }
                }
            }
        }
        
    }

}

