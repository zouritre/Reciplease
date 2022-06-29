//
//  MockURLProtocol.swift
//  Le-BaluchonTests
//
//  Created by Bertrand Dalleau on 30/05/2022.
//

import XCTest

extension MockURLProtocol {
    class someError: Error {}
}

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse?, Data?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data, error) = try handler(request)
            
            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            else {
                guard let response = response else {
                    client?.urlProtocolDidFinishLoading(self)
                    return
                }

                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                
                guard let data = data else {
                    client?.urlProtocolDidFinishLoading(self)
                    return
                }

                client?.urlProtocol(self, didLoad: data)
                client?.urlProtocolDidFinishLoading(self)
            }
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
    }
}
