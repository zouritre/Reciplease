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
        
        cell.recipe = self.recipes[indexPath.row]
        
        return cell
        
    }
    
    
    
}

class RecipeSearchResultViewController: UIViewController {

    /// Ingredients chosen by the user
    var ingredients: [String] = []
    
    /// Recipes retrieved from API according to user selected ingredients
    var recipes: [Recipe] = []
    
    var selectedRecipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRecipes()
        
    }
    
    @IBOutlet weak var resultLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    @IBOutlet weak var noRecipeFoundLabel: UILabel!
    
    func getRecipes() {
        
        RecipeSearchService().getRecipes(for: ingredients) { [weak self] recipes, error in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                
                // Check if there's error in response
                if let error = error {
                    
                    self.resultLoadingIndicator.isHidden = true
                    
                    guard error as? RecipeSearchError != RecipeSearchError.noRecipeFound else {
                        
                        self.noRecipeFoundLabel.text = error.localizedDescription
                        self.noRecipeFoundLabel.isHidden = false
                        
                        return
                    }
                    
                    self.alert(message: error.localizedDescription)
                    
                    return
                    
                }
                else {
                    
                    // Check if there's data in response
                    guard let recipes = recipes, error == nil else {
                        
                        self.alert(message: RecipeSearchError.unexpectedDataError.localizedDescription)
                        
                        return
                    
                    }
                    
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
                
                targetVC.recipe = self.selectedRecipe
                
            }
            
        }
    }
}
