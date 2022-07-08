//
//  FavoriteSearchServiceTest.swift
//  RecipleaseTests
//
//  Created by Bertrand Dalleau on 30/06/2022.
//

import XCTest
@testable import Reciplease

class FavoriteSearchServiceTest: XCTestCase {

    var favoriteSearchService = FavoriteSearchService()
    
    let recipe = Recipe()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //Remove all elements from the table Favorite of the datastore
        Favorite.query().fetch().remove()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllFavoritesShouldBeFetchedFromDatastore() {
        
        //Given
        recipe.title = "test"
        
        //When
        //Append a recipe to the 'Favorite' table of the datastore
        Favorite(dictionary: ["recipe": Recipe()]).commit()
        
        let expectation = expectation(description: "Wait for queue change")
        
        favoriteSearchService.getFavoriteRecipes() { recipe in
        
            //Then
            XCTAssertEqual(recipe.count, 1)

            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.05)
    }
    
    func testNoFavoritesShouldBeReturnedFromDatastore() {
        
        //Given
        //No data appended to datastore
        
        //When
        let expectation = expectation(description: "Wait for queue change")
        
        favoriteSearchService.getFavoriteRecipes() { recipe in
        
            //Then
            XCTAssertEqual(recipe.count, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.05)
    }

    func testRecipeShouldBeAddedToDataStore() {
        
        //Given
        recipe.title = "test"

        //When
        favoriteSearchService.updateFavorites(recipe: recipe)
        
        //Then
        XCTAssertEqual(Favorite.query().fetch().count, 1)
        
    }

    func testRecipeShouldBeRemovedFromDataStore() {
        
        //Given
        recipe.title = "test"
        
        //Append the recipe to the 'Favorite' table of the datastore
        Favorite(dictionary: ["recipe": recipe]).commit()
        
        //When
        favoriteSearchService.updateFavorites(recipe: recipe)
        
        //Then
        XCTAssertEqual(Favorite.query().fetch().count, 0)
        
    }
    
    func testAllFavoritesShouldBeFoundInDataStore() {
        
        //Given
        recipe.title = "test"
        
        //Append the recipe to the 'Favorite' table of the datastore
        Favorite(dictionary: ["recipe": recipe]).commit()
        
        //When
        let expectation = expectation(description: "Wait for queue change")
        
        favoriteSearchService.checkIsFavoriteRecipe(recipe: recipe) { isFavorite in
            
            //Then
            XCTAssertTrue(isFavorite)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.05)
    
    }
    
    func testNoFavoritesShouldBeFoundInDataStore() {
        
        //Given
        recipe.title = "test"
        
        //Not appending any recipe to the datastore
        
        //When
        let expectation = expectation(description: "Wait for queue change")

        favoriteSearchService.checkIsFavoriteRecipe(recipe: recipe) { isFavorite in
            
            //Then
            XCTAssertFalse(isFavorite)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.05)

    }
    
    func testIngredientsShouldBeEncoded() {
        
        //Given
        recipe.ingredientNames = ["1/3 tbsp"]
        recipe.ingredientsMeasurements = ["2/3 tbsp"]
        
        //Not appending any recipe to the datastore
        
        //When
        var measure: [String] = []
        var name: [String] = []
        
        (name, measure) = favoriteSearchService.encodedIngredients(from: self.recipe)
        
        XCTAssertEqual(name, ["1/3%20tbsp"])
        XCTAssertEqual(measure, ["2/3%20tbsp"])

    }
    
    func testIngredientsShouldBeDecoded() {
        
        //Given
        recipe.ingredientNames = ["1/3%20tbsp"]
        recipe.ingredientsMeasurements = ["2/3%20tbsp"]
        
        //Not appending any recipe to the datastore
        
        //When
        var measure: [String] = []
        var name: [String] = []
        
        (name, measure) = favoriteSearchService.decodedIngredients(from: self.recipe)
        
        XCTAssertEqual(name, ["1/3 tbsp"])
        XCTAssertEqual(measure, ["2/3 tbsp"])

    }
    
}
