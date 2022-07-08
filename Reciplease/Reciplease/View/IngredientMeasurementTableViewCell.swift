//
//  IngredientMeasurementTableViewCell.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 04/07/2022.
//

import UIKit

class IngredientMeasurementTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.ingredientMeasurementLabel.isAccessibilityElement = true
        self.ingredientMeasurementLabel.accessibilityLabel = AccessibilityLabel.ingredientMeasurement.rawValue
        self.ingredientMeasurementLabel.accessibilityHint = AccessibilityHint.ingredientMeasurement.rawValue

        // Configure the view for the selected state
    }

    @IBOutlet weak var ingredientMeasurementLabel: UILabel!
    
}
