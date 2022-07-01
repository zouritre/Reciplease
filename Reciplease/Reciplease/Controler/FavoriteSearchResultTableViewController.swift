//
//  FavoriteSearchResultTableViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 28/06/2022.
//

import UIKit

class FavoriteSearchResultTableViewController: UITableViewController {

    private let favoriteSearchService = FavoriteSearchService()
    
    /// Favorite recipes retrieved from datastore. First element initialized with  a placeholder object wich is ignored at all time to prevent table view row count to be equal 0
    private var recipes: [Recipe] = [Recipe()]
    
    /// Recipe selected by the user from the table view
    private var selectedRecipe: Recipe = Recipe()
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Remove all elements but the first one, preventing infinite appending when navigating back-and-forth
        self.recipes.removeLast(self.recipes.count - 1)
        
        favoriteSearchService.getFavoriteRecipes() { recipes in

            recipes.forEach { recipe in
                
                //Store each favorite recipe retrieved form datastore
                self.recipes.append(recipe)
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

//         Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBOutlet weak var noFavoriteFoundLabel: UILabel!
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.recipes.count > 1 && indexPath.row > 0 {
            //At least one favorite recipe has been retrieved from datastore, ignore first element of the array
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipe") as? RecipeTableViewCell else {

                return UITableViewCell()
            }
            //Set the recipe property of the subclassed cell and returns it
            cell.recipe = recipes[indexPath.row]
            
            return cell
        }
        else if self.recipes.count > 1 && indexPath.row == 0 {
            //At least one favorite recipe has been retrieved from datastore, dequeue a cell not visible to the user for the first row
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "emptyRow") else {
                return UITableViewCell()
            }
            
            return cell
        }
        else {
            //No favorite recipe has been trieved from datastore and the table view row count is equal 1 instead of 0 thanks to the placeholder object
            //Effectivly allowing the dequeue of another cell. Would not have been possible if table view row count was 0.
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "noRecipe") else {
                return UITableViewCell()
            }
            
            return cell
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let cell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else {
                return
            }
            
            guard let recipe = cell.recipe else {
                return
            }
            
            //Remove the favorite recipe from datastore
            favoriteSearchService.updateFavorites(recipe: recipe)
            
            //Remove the element from the array used as a source for the table view
            self.recipes.remove(at: indexPath.row)
            
            //Delete the row visually from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if self.recipes.count == 1 {
                //Reload table view if only the placeholder object is in the array used as source, effectivly dequeuing a default cell called 'noRecipe'
                tableView.reloadData()
                
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
