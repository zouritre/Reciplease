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
            
//            let targetSize = CGSize(width: 100, height: 100)
//
//            let resizedImage = loadedImage.scalePreservingAspectRatio(targetSize: targetSize)
//
//            guard let resizedImage = loadedImage.resizeImageTo(size: targetSize) else {
//                return
//            }
            self?.image = loadedImage
            self?.layoutIfNeeded()
            self?.contentMode = .scaleAspectFill
        }
    }
}

extension UIImage {
    
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
    
    func resizeImageTo(size: CGSize) -> UIImage? {
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            self.draw(in: CGRect(origin: CGPoint.zero, size: size))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return resizedImage
        }
}
