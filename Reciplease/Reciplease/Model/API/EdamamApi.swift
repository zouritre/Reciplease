//
//  EdamamApi.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 23/06/2022.
//

import Foundation
import Alamofire

class EdamamApi {
    
    private static var app_id = "825b2af5"
    
    private static var app_key = "fc72faaa2c5956be8936da71e0a8ad3a"
    
    private static var baseUrl = "https://api.edamam.com"
    
    static var recipeSearchUrl: String {
        
        //URL for recipes with cooking time >= 1 minute
        return "\(baseUrl)/api/recipes/v2?app_id=825b2af5&app_key=fc72faaa2c5956be8936da71e0a8ad3a&type=public"
        
    }
    
    static var recipeSearchMethod: HTTPMethod = .get
}
