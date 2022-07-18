//
//  recipeSearchLabel.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 24/06/2022.
//

import Foundation
import UIKit

class recipeSearchLabel: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        switch self.tag {
        case 1:
            self.font = UIFont(name: "Futura", size: 20.0)
            
        case 2:
            self.font = UIFont(name: "Futura", size: 14.0)
            
        default:
            self.font = UIFont(name: "Futura", size: 11.0)
        }
        
        self.textColor = .white
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
