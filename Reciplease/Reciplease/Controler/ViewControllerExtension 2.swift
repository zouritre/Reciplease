//
//  ExtensionViewController.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 10/06/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 105.0/255.0, green: 103.0/255.0, blue: 115.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 239.0/255.0, green: 241.0/255.0, blue: 243.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func alert(message: String) {
        
        let alertView = UIAlertController.init(title: message, message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertView, animated: true)
    }

}

extension UIImageView {
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
