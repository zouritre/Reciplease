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

        }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
    
    }
}
