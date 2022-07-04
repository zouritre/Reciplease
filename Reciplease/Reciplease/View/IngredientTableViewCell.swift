//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 24/06/2022.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.ingredientLabel.isAccessibilityElement = true
        self.ingredientLabel.accessibilityLabel = AccessibilityLabel.chosenIngredient.rawValue
        self.ingredientLabel.accessibilityHint = AccessibilityHint.chosenIngredient.rawValue

        // Configure the view for the selected state
    }

    @IBOutlet weak var ingredientLabel: UILabel!
    
}
