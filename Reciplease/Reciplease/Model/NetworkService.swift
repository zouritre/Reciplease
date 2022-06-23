//
//  NetworkService.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 23/06/2022.
//

import Foundation
import Alamofire

class NetworkService {
    
    /// Singleton
    static var shared = NetworkService()
    
    private init() {}
    
    /// Send an HTTPS request to specified URL
    /// - Parameters:
    ///   - url: URL of the request
    ///   - method: Method used to send the request
    ///   - completionHandler: The data received in the response if any or an error
    func makeRequest(urlString: String, method: HTTPMethod, completionHandler: @escaping (_ data: Data?, _ errorDescription: String?) -> Void) {
        
        // Encode the string to correct URL format
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = url else {
            return
        }
        
        // Emit a request to specified URL
        AF.request(url, method: method).validate().response { response in
            
            switch response.result {
                
            case .success(let data):
                completionHandler(data, nil)
                
            case .failure(let error):
                completionHandler(nil, "\(error) -> \(error.localizedDescription)")
                
            }
        }
    }

}

