//
//  FavoriteSearchResultTableViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 28/06/2022.
//

import UIKit

class FavoriteSearchResultTableViewController: UITableViewController {

    private let favoriteSearchService = FavoriteSearchService()
    
    private var recipes: [Recipe] = []
    
    /// Recipe selected by the user from the table view
    private var selectedRecipe: Recipe?
    
    override func viewWillAppear(_ animated: Bool) {
        
        favoriteSearchService.getFavoriteRecipes() { recipes in
                
            self.recipes = recipes

            self.tableView.reloadData()
            print("reloaded")
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
        
        print("in section number")
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("in row number", recipes.count)
        return (self.recipes.count > 0) ? self.recipes.count : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("in cellforrow")
        if self.recipes.count > 0 {
            
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "recipe") as? RecipeTableViewCell else {
                print("cell vide")

                return UITableViewCell()
            }
            print("returned cell")
            //Set the recipe property of the subclassed cell and returns it
            cell.recipe = recipes[indexPath.row]
            
            return cell
        }
        else {
            
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "noRecipe") else {
                print("fail 1")
                return UITableViewCell()
            }
            print("cell norecipe")

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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
