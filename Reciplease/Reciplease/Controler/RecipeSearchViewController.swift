//
//  RecipeSearchViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 21/06/2022.
//

import UIKit
import SharkORM

extension RecipeSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.ingredients.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.ingredientTableView.dequeueReusableCell(withIdentifier: "ingredient") as? IngredientTableViewCell else {
            
            return UITableViewCell()
            
        }
        // Display the chosen ingredient in the cell
        cell.ingredientLabel.text = "- \(self.ingredients[indexPath.row])"
        
        //Set chosen ingredient name as accessibility value for the ingredient label
        cell.ingredientLabel.accessibilityValue = self.ingredients[indexPath.row]
        
        return cell
        
    }
    
    
    
}

extension RecipeSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
            
        guard let splittedSearchText = searchBar.text?.split(separator: ",") else {
            print("search bar text splitting returned empty array")
            return
        }
        
        for substring in splittedSearchText {
            
            // Prevent duplicate string
            if self.ingredients.firstIndex(of: String(substring).capitalized) == nil {
                
                self.ingredients.append(String(substring).capitalized)
                
            }
        }
        
        self.ingredientTableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        // Hide keyboard when Cancel button is tapped
        self.searchBar.resignFirstResponder()
        
    }
}

class RecipeSearchViewController: UIViewController {
    
    var ingredients: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.searchBar.delegate = self
        self.searchBar.isAccessibilityElement = true
        self.searchBar.accessibilityHint = "Search bar for ingredients"
        self.searchBar.accessibilityValue = "Lemon, cheese, sausages"
        self.searchBar.accessibilityLabel = "Search bar"
        
    }

    @IBOutlet weak var ingredientTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func clearButton(_ sender: Any) {
        
        self.ingredients.removeAll()
        
        self.ingredientTableView.reloadData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchResult" {
            
            if let targetVc = segue.destination as? RecipeSearchResultViewController {
                
                targetVc.ingredients = self.ingredients
                
            }
        }
    }
}

