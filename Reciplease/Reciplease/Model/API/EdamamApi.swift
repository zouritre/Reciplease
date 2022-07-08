//
//  EdamamApi.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 23/06/2022.
//

import Foundation
import Alamofire

class EdamamApi {
    
    private static var baseUrl = "https://api.edamam.com"
    
    static var recipeSearchUrl: String {
        
        //URL for recipes with cooking time >= 1 minute
        return "\(baseUrl)/api/recipes/v2?app_id=\(EdamamApiConstant.app_id)&app_key=\(EdamamApiConstant.app_key)&type=public"
        
    }
    
    static var recipeSearchMethod: HTTPMethod = .get
}
