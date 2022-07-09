//
//  EdamamApi.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 23/06/2022.
//

import Foundation
import Alamofire

class EdamamApi {
    
    private static var queryItems = [
        URLQueryItem(name: "app_id", value: EdamamApiConstant.app_id),
        URLQueryItem(name: "app_key", value: EdamamApiConstant.app_key),
        URLQueryItem(name: "type", value: "public"),
        URLQueryItem(name: "time", value: "1-1000"),
        URLQueryItem(name: "field", value: "label"),
        URLQueryItem(name: "field", value: "ingredients"),
        URLQueryItem(name: "field", value: "totalTime"),
        URLQueryItem(name: "field", value: "images"),
        URLQueryItem(name: "q", value: "")
    ]
    
    private static var baseUrl: URL? {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.edamam.com"
        components.path = "/api/recipes/v2"
        
        return components.url
        
    }
    
    static func recipeSearchUrl(q: String) -> URL? {
        //Remove last element to prevent infinite appending
        self.queryItems.removeLast()
        self.queryItems.append(URLQueryItem(name: "q", value: q))
        
        var components = URLComponents()
        
        components.queryItems = self.queryItems
        
        return components.url(relativeTo: self.baseUrl)?.absoluteURL
        
    }
}
