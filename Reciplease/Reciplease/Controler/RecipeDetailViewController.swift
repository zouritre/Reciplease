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
        
        //Set the cell title to each ingredient of the recipe
        cell.ingredientLabel.text = "- \(recipe.ingredientsMeasurements[indexPath.row])"
        
        return cell
        
    }
    
    
    
}

class RecipeDetailViewController: UIViewController {
    
    /// Recipe selected by the user
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setFavoriteButtonImage()

        self.setupUI(with: self.recipe)
        
    }
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var cookingTimeLabel: UILabel!
    
    @IBOutlet weak var ingredientsTableView: UITableView!

    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBAction func addToFavoriteButton(_ sender: UIBarButtonItem) {
        
        self.updateFavorites()
        
        self.setFavoriteButtonImage()
        
    }
    
    /// Add a recipe to datastore if it's not already in, otherwise removes it
    private func updateFavorites() {
        
        self.checkIsFavoriteRecipe() { isFavorite in
            
            guard let recipe = self.recipe else {
                return
            }
            
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
    private func checkIsFavoriteRecipe(isFavorite: ((Bool) -> Void)? = nil) {
        
        guard let recipe = self.recipe else {
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
    
    /// Set the UIBarItem star image to hollow or filled according to the recipe being in favorites or not
    private func setFavoriteButtonImage() {
        
        checkIsFavoriteRecipe() { isFavorite in
            
            switch isFavorite {
                
            case true:
                //Set a filled star image
                self.favoriteButton.image = UIImage(systemName: "star.fill")

            case false:
                //Set a hollow star image
                self.favoriteButton.image = UIImage(systemName: "star")
            }
            
        }
    }
    
    /// Set the value of the UI elements according to the recipe informations
    /// - Parameter recipe: The recipe selected by the user
    private func setupUI(with recipe: Recipe?) {
        
        self.recipeImage.frame = CGRect(x: 0,y: 0,width: 394,height: 326.5)
        
        guard let recipe = recipe else {
            return
        }
        
        self.recipeImage.loadFrom(URLAddress: recipe.imageLink)
        
        self.cookingTimeLabel.text = String(recipe.cookingTime)
        
        self.recipeTitle.text = recipe.title
        
    }
    
}
