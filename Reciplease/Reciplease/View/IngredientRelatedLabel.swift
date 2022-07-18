//
//  IngredientRelatedLabel.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 22/06/2022.
//

import UIKit

class IngredientRelatedLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.font = UIFont(name: "Chalkduster", size: 20.0)
        self.textColor = .white
        
        self.isAccessibilityElement = true
        self.accessibilityHint = AccessibilityHint.ingredientListHeader.rawValue
        self.accessibilityLabel = AccessibilityLabel.ingredientListHeader.rawValue
        self.accessibilityValue = self.text
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
