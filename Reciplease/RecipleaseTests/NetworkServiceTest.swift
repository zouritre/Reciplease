//
//  NetworkServiceTest.swift
//  RecipleaseTests
//
//  Created by Bertrand Dalleau on 25/06/2022.
//

import XCTest
@testable import Reciplease

class NetworkServiceTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        NetworkService.shared.configuration.protocolClasses = [MockURLProtocol.self]
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMakeRequestShouldReturnDataIfServerResponseIsValid() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.randomData
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        NetworkService.shared.makeRequest(urlString: "https://stackoverflow.com", method: .get){ data, error in
            
        // Then
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
        
    }
    
    func testMakeRequestShouldReturnErrorIfServerResponseIsNotValid() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseKO
        let data: Data? = FakeResponse.randomData
        let error: Error? = nil

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        //Random parameters, does not matter
        NetworkService.shared.makeRequest(urlString: "https://stackoverflow.com", method: .get){ data, error in

        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
        
    }

    func testMakeRequestShouldReturnFailCallbackIfEror() {
        
        //Given
        let response: HTTPURLResponse? = FakeResponse.responseOK
        let data: Data? = FakeResponse.correctRecipeData
        let error: Error? = FakeResponse.anError

        MockURLProtocol.requestHandler = { request in
            return (response, data, error)
        }
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        //Random parameters, does not matter
        NetworkService.shared.makeRequest(urlString: "https://stackoverflow.com", method: .get){ data, error in

        // Then
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        //wait 50ms for closure to return
        wait(for: [expectation], timeout: 0.05)
        
    }
}
