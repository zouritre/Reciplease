//
//  RecipeSearchResultViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 23/06/2022.
//

import UIKit

extension RecipeSearchResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else {
            return
        }
        
        guard let selectedCellRecipe = selectedCell.recipe else {
            return
        }
        
        //Retrieve the recipe of the selected cell in the table view
        self.selectedRecipe = selectedCellRecipe
        
        performSegue(withIdentifier: "searchResultDetail", sender: self)
    }
    
}
extension RecipeSearchResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.recipes.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.recipeTableView.dequeueReusableCell(withIdentifier: "recipe") as? RecipeTableViewCell else {
            return UITableViewCell()
            
        }
        
        //Set the recipe property of the subclassed cell and returns it
        cell.recipe = self.recipes[indexPath.row]
        
        return cell
        
    }
    
    
    
}

class RecipeSearchResultViewController: UIViewController {

    /// Ingredients chosen by the user
    var ingredients: [String] = []
    
    /// Recipes retrieved from API according to user selected ingredients
    var recipes: [Recipe] = []
    
    /// Recipe selected by the user from the table view
    var selectedRecipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getRecipes()
        
    }
    
    @IBOutlet weak var resultLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    @IBOutlet weak var noRecipeFoundLabel: UILabel!
    
    /// Retrieve from API the recipes whose ingredients matches the user selected ingredients
    func getRecipes() {
        
        RecipeSearchService().getRecipes(for: ingredients) { [weak self] recipes, error in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                
                // Check if there's error in response
                if let error = error {
                    
                    //Hide the loading indicator
                    self.resultLoadingIndicator.isHidden = true
                    
                    guard error as? RecipeSearchError != RecipeSearchError.noRecipeFound else {
                        
                        //Display a message in place of the table view
                        self.noRecipeFoundLabel.text = error.localizedDescription
                        self.noRecipeFoundLabel.isHidden = false
                        
                        return
                    }
                    
                    //Display a popup message
                    self.alert(message: error.localizedDescription)
                    
                    return
                    
                }
                else {
                    
                    // Check if there's data in response
                    guard let recipes = recipes, error == nil else {
                        
                        self.alert(message: RecipeSearchError.unexpectedDataError.localizedDescription)
                        
                        return
                    
                    }
                    
                    //Store the recipes gathered form API and update the table view
                    self.recipes = recipes
                    
                    self.resultLoadingIndicator.isHidden = true
                    
                    self.recipeTableView.reloadData()
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchResultDetail" {
            
            if let targetVC = segue.destination as? RecipeDetailViewController {
                
                //Send the selected recipe
                targetVC.recipe = self.selectedRecipe
                
            }
            
        }
    }
}
