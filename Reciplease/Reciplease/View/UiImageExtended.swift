//
//  UiImageExtended.swift
//  Reciplease
//
//  Created by Bertrand Dalleau on 01/07/2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    /// Download an image from specified URL and displays it in the UIImageView
    /// - Parameter URLAddress: URL contaning the image
    func loadFrom(URLAddress: String) {
        
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            
            guard let imageData = try? Data(contentsOf: url) else {
                
                return
                
            }
            
            guard let loadedImage = UIImage(data: imageData) else {
                
                return
                
            }
            
            self?.image = loadedImage
            
        }
    }
}
