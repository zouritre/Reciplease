//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 24/06/2022.
//

import Foundation
import UIKit

@IBDesignable
class RecipeTableViewCell: UITableViewCell {
    var recipe: Recipe? {
        willSet {
            guard let newValue = newValue else { return }
            
            //Set the outlet values
            self.recipeTitle.text = newValue.title
            self.ingredientMeasurement.text = newValue.ingredientNames.joined(separator: ", ")
                .capitalizingFirstLetter()
            self.recipeImage.loadFrom(URLAddress: newValue.imageLink)
            self.cookingTime.text = String(newValue.cookingTime)
            
            //Set the accessibility values for each outlet
            self.recipeTitle.accessibilityValue = self.recipeTitle.text
            self.ingredientMeasurement.accessibilityValue = self.ingredientMeasurement.text
            self.cookingTime.accessibilityValue = self.cookingTime.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Enable accessibility on each outlet and set their default hint ans label
        self.cookingTime.isAccessibilityElement = true
        self.recipeImage.isAccessibilityElement = true
        self.recipeTitle.isAccessibilityElement = true
        self.ingredientMeasurement.isAccessibilityElement = true
        
        self.cookingTime.accessibilityLabel = AccessibilityLabel.cookingTime.rawValue
        self.recipeImage.accessibilityLabel = AccessibilityLabel.recipeImage.rawValue
        self.recipeTitle.accessibilityLabel = AccessibilityLabel.recipeTitle.rawValue
        self.ingredientMeasurement.accessibilityLabel = AccessibilityLabel.ingredients.rawValue

        self.cookingTime.accessibilityHint = AccessibilityHint.cookingTime.rawValue
        self.recipeImage.accessibilityHint = AccessibilityHint.recipeImage.rawValue
        self.recipeTitle.accessibilityHint = AccessibilityHint.recipeTitle.rawValue
        self.ingredientMeasurement.accessibilityHint = AccessibilityHint.ingredients.rawValue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet weak var cookingTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientMeasurement: UILabel!
    
}
