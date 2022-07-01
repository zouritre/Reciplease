//
//  StringExtended.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 01/07/2022.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
