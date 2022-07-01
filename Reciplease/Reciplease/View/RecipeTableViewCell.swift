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
            
            guard let newValue = newValue else {
                return
            }
            
            self.recipeTitle.text = newValue.title
            self.recipeIngredients.text = newValue.ingredientNames.joined(separator: ", ")
                .capitalizingFirstLetter()
            
            self.recipeImage.loadFrom(URLAddress: newValue.imageLink)
            self.cookingTime.text = String(newValue.cookingTime)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var cookingTime: UILabel!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var recipeIngredients: UILabel!
}
