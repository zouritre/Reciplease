//
//  FavoriteSearchViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 28/06/2022.
//

import UIKit

extension FavoriteSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedCell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else {
            return
        }
        
        guard let selectedCellRecipe = selectedCell.recipe else {
            return
        }
        
        //Retrieve the recipe of the selected cell
        self.selectedRecipe = selectedCellRecipe
        
        performSegue(withIdentifier: "favoriteRecipeDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let cell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else {
                return
            }
            
            guard let recipe = cell.recipe else {
                return
            }
            
            //Remove the favorite recipe from datastore
            self.favoriteSearchService.updateFavorites(recipe: recipe)
            
            //Remove the element from the array used as a source for the table view
            self.recipes.remove(at: indexPath.row)
            
            //Delete the row visually from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if self.recipes.count == 0 {
                
                self.noRecipeFoundLabel.isHidden = false
            }
            else {
                self.noRecipeFoundLabel.isHidden = true
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}

extension FavoriteSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.recipes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.favoriteRecipeTableView.dequeueReusableCell(withIdentifier: "recipe") as? RecipeTableViewCell else {
            return UITableViewCell()
            
        }
        
        //Set the recipe property of the subclassed cell
        cell.recipe = self.recipes[indexPath.row]
        
        return cell
        
    }
    
    
    
}

class FavoriteSearchViewController: UIViewController {
    
    private let favoriteSearchService = FavoriteSearchService()
    
    /// Favorite recipes retrieved from datastore. First element initialized with  a placeholder object wich is ignored at all time to prevent table view row count to be equal 0
    var recipes: [Recipe] = []
    
    /// Recipe selected by the user from the table view
    var selectedRecipe: Recipe = Recipe()
    
    override func viewWillAppear(_ animated: Bool) {
        
        favoriteSearchService.getFavoriteRecipes() { favRecipes in
            
            self.recipes = favRecipes
            
            self.resultLoadingIndicator.isHidden = true
            
            self.favoriteRecipeTableView.reloadData()
            
            if self.recipes.count == 0 {
                
                self.noRecipeFoundLabel.isHidden = false
            }
            else {
                self.noRecipeFoundLabel.isHidden = true
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var resultLoadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var favoriteRecipeTableView: UITableView!
    
    @IBOutlet weak var noRecipeFoundLabel: UILabel!
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "favoriteRecipeDetail" {
            
            if let targetVC = segue.destination as? RecipeDetailViewController {
                
                //Send the selected recipe
                targetVC.recipe = self.selectedRecipe
                
            }
            
        }
    }
}

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */
