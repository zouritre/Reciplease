//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 26/06/2022.
//

import UIKit

extension RecipeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let recipe = self.recipe else {
            return 0
        }
        
        return recipe.ingredientNames.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredient") as? IngredientTableViewCell else {
            
            return UITableViewCell()
            
        }
        
        guard let recipe = self.recipe else {
            return UITableViewCell()
        }
        
        cell.ingredientLabel.text = "- \(recipe.ingredientsMeasurements[indexPath.row])"
        
        return cell
        
    }
    
    
    
}

class RecipeDetailViewController: UIViewController {

    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.recipeImage.frame = CGRect(x: 0,y: 0,width: 394,height: 326.5)
        
        guard let recipe = self.recipe else {
            return
        }
        
        self.recipeImage.loadFrom(URLAddress: recipe.imageLink)
        
    }
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var ingredientsTableView: UITableView!

}
