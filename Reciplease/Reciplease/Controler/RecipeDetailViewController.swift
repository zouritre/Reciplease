//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 26/06/2022.
//

import UIKit

extension RecipeDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = self.recipe?.ingredientNames.count else {
            return 0
        }
        
        return count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.ingredientsTableView.dequeueReusableCell(withIdentifier: "ingredient") as? IngredientMeasurementTableViewCell else {
            
            return UITableViewCell()
            
        }
        
        //Set the cell title to each ingredient of the recipe
        cell.ingredientMeasurementLabel.text = "- \(self.recipe?.ingredientsMeasurements[indexPath.row] ?? "empty")"
        cell.ingredientMeasurementLabel.accessibilityValue = self.recipe?.ingredientsMeasurements[indexPath.row]
        
        return cell
        
    }
    
    
    
}

class RecipeDetailViewController: UIViewController {
    
    private let favoriteSearchService = FavoriteSearchService()

    /// Recipe selected by the user
    var recipe: Recipe?
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.setFavoriteButtonImage()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI(with: self.recipe)
        
        self.recipeImage.isAccessibilityElement = true
        self.recipeTitle.isAccessibilityElement = true
        self.cookingTimeLabel.isAccessibilityElement = true
        self.favoriteButton.isAccessibilityElement = true
        
        self.recipeImage.accessibilityHint = AccessibilityHint.recipeImage.rawValue
        self.recipeTitle.accessibilityHint = AccessibilityHint.recipeTitle.rawValue
        self.cookingTimeLabel.accessibilityHint = AccessibilityHint.cookingTime.rawValue
        self.favoriteButton.accessibilityHint = AccessibilityHint.favoriteButton.rawValue
        
        self.recipeImage.accessibilityLabel = AccessibilityLabel.recipeImage.rawValue
        self.recipeTitle.accessibilityLabel = AccessibilityLabel.recipeTitle.rawValue
        self.cookingTimeLabel.accessibilityLabel = AccessibilityLabel.cookingTime.rawValue
        self.favoriteButton.accessibilityLabel = AccessibilityLabel.favoriteButton.rawValue
        
        self.recipeTitle.accessibilityValue = self.recipe?.title
        self.cookingTimeLabel.accessibilityValue = self.recipe?.cookingTime


    }
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var cookingTimeLabel: UILabel!
    
    @IBOutlet weak var ingredientsTableView: UITableView!

    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBAction func addToFavoriteButton(_ sender: UIBarButtonItem) {
        
        guard let recipe = recipe else {
            return
        }

        favoriteSearchService.updateFavorites(recipe: recipe)
        
        self.setFavoriteButtonImage()
        
    }
    
    /// Set the UIBarItem star image to hollow or filled according to the recipe being in favorites or not
    private func setFavoriteButtonImage() {
        
        guard let recipe = recipe else {
            return
        }

        favoriteSearchService.checkIsFavoriteRecipe(recipe: recipe) { isFavorite in
            
            switch isFavorite {
                
            case true:
                //Set a filled star image
                self.favoriteButton.image = UIImage(systemName: "star.fill")
                self.favoriteButton.accessibilityValue = "Checked, recipe is in favorite"

            case false:
                //Set a hollow star image
                self.favoriteButton.image = UIImage(systemName: "star")
                self.favoriteButton.accessibilityValue = "Unchecked, recipe is not in favorite"
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
