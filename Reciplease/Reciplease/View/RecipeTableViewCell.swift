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
            
            //Set the outlet values
            self.recipeTitle.text = newValue.title
            self.recipeIngredients.text = newValue.ingredientNames.joined(separator: ", ")
                .capitalizingFirstLetter()
            self.recipeImage.loadFrom(URLAddress: newValue.imageLink)
            self.cookingTime.text = String(newValue.cookingTime)
            
            //Set the accessibility values for each outlet
            self.recipeTitle.accessibilityValue = self.recipeTitle.text
            self.recipeIngredients.accessibilityValue = self.recipeIngredients.text
            
            guard let cookingTime = self.cookingTime.text else {
                
                self.cookingTime.accessibilityValue = self.cookingTime.text
                
                return
            }
            
            self.cookingTime.accessibilityValue = self.getReadableTime(from: cookingTime)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //Enable accessibility on each outlet and set their default hint
        self.cookingTime.isAccessibilityElement = true
        self.recipeImage.isAccessibilityElement = true
        self.recipeTitle.isAccessibilityElement = true
        self.recipeIngredients.isAccessibilityElement = true
        
        self.cookingTime.accessibilityLabel = "Cooking time"
        self.cookingTime.accessibilityHint = "Recipe preparation duration"
        
        self.recipeImage.accessibilityLabel = "Recipe Image"
        self.recipeImage.accessibilityHint = "Illustration of the recipe"
        
        self.recipeTitle.accessibilityLabel = "Title"
        self.recipeTitle.accessibilityHint = "Name of the recipe"
        
        self.recipeIngredients.accessibilityLabel = "Ingredients"
        self.recipeIngredients.accessibilityHint = "The recipe ingredients"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var cookingTime: UILabel!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeTitle: UILabel!
    
    @IBOutlet weak var recipeIngredients: UILabel!
    
    func getReadableTime(from timeString: String) -> String {
        
        var timeString1 = timeString
        
        if timeString1.contains("h") {
            
            guard timeString1.contains("m") else {
                //Cooking time is > 1 hour and doesn't contain minutes
                
                //Remove the 'h' character
                timeString1.removeLast()
                
                let hourString = timeString1
                
                let rawHour = Int(hourString)
                
                guard let rawHour = rawHour else {
                    print("fail Int conversion")
                    return "\(hourString) hour"
                }
                
                return rawHour > 1 ? "\(hourString) hours" : "\(hourString) hour"
            }
            
            //Cooking time is > 1 hour and contain minutes

            //Separate hours from minutes
            let splittedTime = timeString1.split(separator: " ")
            
            var minutes = String(splittedTime[1])
            
            //Remove the 'm' character
            minutes.removeLast()
            
            var hour = String(splittedTime[0])
            
            //Remove the 'h' character
            hour.removeLast()
            
            guard let minuteStringToInt = Int(minutes) else {
                return "\(hour) hour \(minutes) minutes"
            }
            
            guard let hourStringToInt = Int(hour) else {
                return "\(hour) hour \(minutes) minutes"
            }
            
            let minuteGrammar = minuteStringToInt > 1 ? "minutes" : "minute"
            
            let hourGrammar = hourStringToInt > 1 ? "hours" : "hour"
            
            return "\(hour) \(hourGrammar) \(minutes) \(minuteGrammar)"
        }
        else {
            
            //Cooking time is < 1 hour
            
            //Remove the 'm' character
            timeString1.removeLast()
            
            guard let minuteStringToInt = Int(timeString1) else {
                return "\(timeString1) minute"
            }
            
            return minuteStringToInt > 1 ? "\(timeString1) minutes" : "\(timeString1) minute"

        }
        
    }
}
