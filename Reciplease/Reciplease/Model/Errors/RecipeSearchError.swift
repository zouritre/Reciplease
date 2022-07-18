//
//  RecipeSearchError.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 24/06/2022.
//

import Foundation

extension RecipeSearchError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noDataReceived:
            return NSLocalizedString("No data received from server", comment: "")
            
        case .unexpectedDataFormat:
            return NSLocalizedString("Data received is not convertible to JSON", comment: "")
            
        case .noRecipeFound:
            return NSLocalizedString("No recipe found for provided ingredients", comment: "")

        case .unexpectedDataError:
            return NSLocalizedString("Unexpected error when retrieving data", comment: "")
        }
    }
}

enum RecipeSearchError: Error {
    case noDataReceived
    case unexpectedDataFormat
    case noRecipeFound
    case unexpectedDataError
}
