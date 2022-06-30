//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 26/06/2022.
//

import UIKit

extension RecipeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipe.ingredientNames.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredient") as? IngredientTableViewCell else {
            
            return UITableViewCell()
            
        }
        
        //Set the cell title to each ingredient of the recipe
        cell.ingredientLabel.text = "- \(self.recipe.ingredientsMeasurements[indexPath.row])"
        
        return cell
        
    }
    
    
    
}

class RecipeDetailViewController: UIViewController {
    
    private let favoriteSearchService = FavoriteSearchService()

    /// Recipe selected by the user
    var recipe: Recipe = Recipe()
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.setFavoriteButtonImage()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI(with: self.recipe)
        
    }
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var cookingTimeLabel: UILabel!
    
    @IBOutlet weak var ingredientsTableView: UITableView!

    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBAction func addToFavoriteButton(_ sender: UIBarButtonItem) {
        
        favoriteSearchService.updateFavorites(recipe: self.recipe)
        
        self.setFavoriteButtonImage()
        
    }
    
    /// Set the UIBarItem star image to hollow or filled according to the recipe being in favorites or not
    private func setFavoriteButtonImage() {
        
        favoriteSearchService.checkIsFavoriteRecipe(recipe: self.recipe) { isFavorite in
            
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
