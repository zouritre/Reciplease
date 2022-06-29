//
//  RecipeSearchServiceTest.swift
//  RecipleaseTests
//
//  Created by Bertrand Dalleau on 25/06/2022.
//

import XCTest
@testable import Reciplease

class RecipeSearchServiceTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NetworkService.shared.configuration.protocolClasses = [MockURLProtocol.self]

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetRecipesShouldReturnCorrectDataIfServerResponseIsValid() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.correctRecipeData
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        RecipeSearchService().getRecipes(for: [""]){ data, error in
            
            
        // Then
            XCTAssertNil(error)
            XCTAssertEqual(data![0].cookingTime, 135.0)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
        
    }
    
    func testGetRecipesShouldReturnFailCallbackIfServerResponseIsNotValid() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseKO
        let data: Data? = FakeResponse.correctRecipeData
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        RecipeSearchService().getRecipes(for: [""]){ data, error in
            
        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
        
    }
    
    func testGetRecipesShouldReturnFailCallbackIfError() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.correctRecipeData
        let error: Error? = FakeResponse.anError

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        RecipeSearchService().getRecipes(for: [""]){ data, error in
            
        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
        
    }
    
    func testGetRecipesShouldReturnFailCallbackIfNoData() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = nil
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        RecipeSearchService().getRecipes(for: [""]){ data, error in
            
        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
        
    }

    func testGetRecipesShouldReturnFailCallbackIfDataDecodingFail() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.randomData
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        RecipeSearchService().getRecipes(for: [""]){ data, error in
            
        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
        
    }
    
    func testGetRecipesShouldReturnFailCallbackIfNoRecipeFound() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.correctEmptyRecipeData
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        RecipeSearchService().getRecipes(for: [""]){ data, error in
            
        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
        
    }
}
