//
//  FakeCurrencySymbolResponse.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 27/05/2022.
//

import Foundation

class FakeResponse {
   
    static let responseOK = HTTPURLResponse(
       url: URL(string: "https://openclassrooms.com")!,
       statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
       url: URL(string: "https://openclassrooms.com")!,
       statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static let randomData = "random".data(using: .utf8)
    
    private static let bundle = Bundle(for: FakeResponse.self)
    
    static var correctRecipeData: Data? {
    
        let url = bundle.url(forResource: "RecipeData", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var correctEmptyRecipeData: Data? {
    
        let url = bundle.url(forResource: "RecipeDataEmpty", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var correctTimeVariationHourData: Data? {
    
        let url = bundle.url(forResource: "CookingTimeInHour", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    
    static var correctTimeVariationMinuteData: Data? {
    
        let url = bundle.url(forResource: "CookingTimeInMinute", withExtension: "json")!
        
        return try! Data(contentsOf: url)
    }
    class someError: Error {}
    
    static var anError = someError()
}
